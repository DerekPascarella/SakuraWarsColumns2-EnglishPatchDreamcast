#!/usr/bin/perl
#
# Written by Derek Pascarella (ateam)
#
# z2_extract - Z2 archive extracter
#
# Usage: z2_extract <Z2_FILE>

use strict;
use File::Path;
use String::HexConvert ':all';

my $z2_file = $ARGV[0];

if(!defined $z2_file || $z2_file eq "")
{
	die "Error: Must specify Z2 file as first argument.\n";
}
elsif(!-e $z2_file)
{
	die "Error: File \"$z2_file\" does not exist.\n";
}
elsif(!-R $z2_file)
{
	die "Error: Cannot open file \"$z2_file\" (not readable).\n";
}

if(-e $z2_file . "_EXTRACTED")
{
	unless(rmtree($z2_file . "_EXTRACTED"))
	{
		die "Error: Unable to delete previously existing extracted files folder.\n";
	}

	sleep 1;

	unless(mkdir $z2_file . "_EXTRACTED")
	{
		die "Error: Unable to create extracted files folder.\n";
	}
}
else
{
	unless(mkdir $z2_file . "_EXTRACTED")
	{
		die "Error: Unable to create extracted files folder.\n";
	}
}

my $header_bytes;
my $seek_header_bytes = 1;

open my $z2_file_handle, '<:raw', $z2_file;

while($seek_header_bytes)
{
	my $header_hex = &read_bytes($z2_file_handle, 4);

	if($header_hex != "54454E32")
	{
		$header_bytes .= $header_hex;
	}
	else
	{
		$seek_header_bytes = 0;
	}
}

my $header_data;
my @header_filenames = unpack '(a32)*', $header_bytes;

print "Source File: $z2_file\n";
print "File Count: " . (scalar(@header_filenames) - 1) . "\n";
print "Header File: $z2_file\_HEADER\n";
print "Target Directory: $z2_file\_EXTRACTED\n\n";

for(my $i = 0; $i < scalar(@header_filenames); $i ++)
{
	if(length($header_filenames[$i]) > 8)
	{
		my $file_offset = substr($header_filenames[$i], 0, 6);

		$header_filenames[$i] = substr($header_filenames[$i], 6);

		my @header_filename_hex = unpack '(a2)*', $header_filenames[$i];

		my $header_filename;

		foreach(@header_filename_hex)
		{
			if($_ ne "00")
			{
				$header_filename .= $_;
			}
		}

		$header_data .= $header_filename . "7C" . uc(ascii_to_hex($file_offset)) . "0A";

		my $file_size = hex(&reverse_hex(&read_bytes_at_offset($z2_file_handle, 4, hex(&reverse_hex($file_offset)) + 4)));
		
		my $file_data = &read_bytes_at_offset($z2_file_handle, $file_size + 12, hex(&reverse_hex($file_offset)));
		
		my @file_data_array = split(//, $file_data);

		print "Extracting " . hex_to_ascii($header_filename) . " ($file_size bytes)... ";

		&write_bytes(\@file_data_array, $z2_file . "_EXTRACTED/" . hex_to_ascii($header_filename));

		print "done!\n";
	}
}

my @header_data_array = split(//, $header_data);

&write_bytes(\@header_data_array, $z2_file . "_HEADER");

close($z2_file_handle);

sub read_bytes
{
	read $_[0], my $bytes, $_[1];
	
	return unpack 'H*', $bytes;
}

sub read_bytes_at_offset
{
	seek $_[0], $_[2], 0;
	read $_[0], my $bytes, $_[1];
	
	return unpack 'H*', $bytes;
}

sub write_bytes
{
	my $array_reference = $_[0];
	my $output_file = $_[1];

	open(BIN, ">", $output_file) or die;
	binmode(BIN);

	for(my $o = 0; $o < @$array_reference; $o += 2)
	{
		my($hi, $lo) = @$array_reference[$o, $o + 1];
		
		print BIN pack "H*", $hi . $lo;
	}

	close(BIN);
}

sub reverse_hex
{
	my @byte_array_reversed;

	my @byte_array = split(//, $_[0]);

	$byte_array_reversed[0] = $byte_array[4];
	$byte_array_reversed[1] = $byte_array[5];
	$byte_array_reversed[2] = $byte_array[2];
	$byte_array_reversed[3] = $byte_array[3];
	$byte_array_reversed[4] = $byte_array[0];
	$byte_array_reversed[5] = $byte_array[1];

	return join('', @byte_array_reversed);
}
