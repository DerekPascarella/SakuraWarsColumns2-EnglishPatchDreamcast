#!/usr/bin/perl
#
# Written by Derek Pascarella (ateam)
#
# z2_build - Z2 archive builder
#
# Usage: z2_build <HEADER_FILE> <TARGET_Z2_FILE>

use strict;
use String::HexConvert ':all';

my $header_file_name = $ARGV[0];
my $target_z2_file = $ARGV[1];

if(!defined $header_file_name || $header_file_name eq "")
{
	die "Error: Must specify header file as first argument.\n";
}
elsif(!defined $target_z2_file || $target_z2_file eq "")
{
	die "Error: Must specify a target Z2 file as second argument.\n";
}

open my $handle, '<', "$header_file_name";
chomp(my @files = <$handle>);
close $handle;

my $header_size = (scalar(@files) * 16) + 4;

(my $source_directory = $header_file_name) =~ s/_HEADER/_EXTRACTED/g;

print "Source Directory: $source_directory\n";
print "File Count: " . scalar(@files) . "\n";
print "Header File: $header_file_name\n";
print "Header Size: $header_size\n\n";

my $header_data;
my $rolling_size = $header_size;

for(my $i = 0; $i < scalar(@files); $i ++)
{
	$files[$i] =~ s/\|.*//;

	my $file_size = (stat "$source_directory/$files[$i]")[7];

	my $file_offset = &reverse_hex(&pad_hex(sprintf("%X", $rolling_size)));

	my $header_line = $file_offset . uc(ascii_to_hex($files[$i]));

	my $empty_to_append = 13 - length($files[$i]);

	if($i == scalar(@files) - 1)
	{
		$empty_to_append += 3;
	}

	foreach(1 .. $empty_to_append)
	{
		$header_line .= "00";
	}

	if($i == scalar(@files) - 1)
	{
		$header_line .= "40";
	}

	$header_data .= $header_line;

	if($file_size % 4 != 0)
	{
		$file_size += 4 - ($file_size % 4);
	}

	$rolling_size += $file_size;
}

my @header_data_array = split(//, $header_data);

&write_bytes(\@header_data_array, $target_z2_file);

for(my $i = 0; $i < scalar(@files); $i ++)
{
	$files[$i] =~ s/\|.*//;
	
	my $file_size = (stat "$source_directory/$files[$i]")[7];

	print "Adding $files[$i] ($file_size bytes) to $target_z2_file... ";

	open my $extracted_file_handle, '<:raw', "$source_directory/$files[$i]";
	my $extracted_file_data = &read_bytes($extracted_file_handle, $file_size);
	close $extracted_file_handle;

	if($file_size % 4 != 0)
	{
		foreach(1 .. 4 - ($file_size % 4))
		{
			$extracted_file_data .= "40";
		}
	}

	my @extracted_file_data_array = split(//, $extracted_file_data);

	&append_bytes(\@extracted_file_data_array, $target_z2_file);

	print "done!\n";
}


sub read_bytes
{
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

sub append_bytes
{
	my $array_reference = $_[0];
	my $output_file = $_[1];

	open(BIN, ">>", $output_file) or die;
	binmode(BIN);

	for(my $o = 0; $o < @$array_reference; $o += 2)
	{
		my($hi, $lo) = @$array_reference[$o, $o + 1];
		
		print BIN pack "H*", $hi . $lo;
	}

	close(BIN);
}

sub pad_hex
{
	my $filesize_hex_padded;

	for(1 .. 6 - length($_[0]))
	{
		$filesize_hex_padded .= "0";
	}

	$filesize_hex_padded .= $_[0];

	return $filesize_hex_padded;
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
