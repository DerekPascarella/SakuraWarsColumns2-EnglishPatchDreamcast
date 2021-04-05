#!/usr/bin/perl

use strict;
use String::HexConvert ':all';

my $source_file = $ARGV[0];
my $target_file = $ARGV[1];

if(!defined $source_file || $source_file eq "")
{
	die "Error: Must specify uncompressed source file as first argument.\n";
}
elsif(!-e $source_file)
{
	die "Error: File \"$source_file\" does not exist.\n";
}
elsif(!-R $source_file)
{
	die "Error: Cannot open file \"$source_file\" (not readable).\n";
}
elsif(!defined $target_file || $target_file eq "")
{
	die "Error: Must specify target compressed TEN2 file as second argument.\n";
}

my $bpe_output;
my $os = $^O;

if($os eq "MSWin32")
{
	$bpe_output = `.\\bpe.exe compress \"$source_file\" \"$target_file\.TEMP\"`;

	if($bpe_output ne ".\\bpe.exe")
	{
		die "Error: BPE compression failed with the following error message:\n$bpe_output\n";
	}
}
elsif($os eq "linux")
{
	chop($bpe_output = `./bpe compress \"$source_file\" \"$target_file\.TEMP\"`);

	if($bpe_output ne "./bp")
	{
		die "Error: BPE compression failed with the following error message:\n$bpe_output\n";
	}
}
else
{
	die "Error: Detected OS is neither Linux nor Windows and is thus unsupported."
}

my $file_size_uncompressed = (stat "$source_file")[7];
my $file_size_uncompressed_hex = &reverse_hex(&pad_hex(sprintf("%X", $file_size_uncompressed)));

my $file_size_compressed = (stat "$target_file\.TEMP")[7];
my $file_size_compressed_hex = &reverse_hex(&pad_hex(sprintf("%X", $file_size_compressed)));

my $header_data = "54454E32" . $file_size_compressed_hex . $file_size_uncompressed_hex;

my @header_data_array = split(//, $header_data);

&write_bytes(\@header_data_array, $target_file);

open my $compressed_file, '<:raw', "$target_file\.TEMP";
my $compressed_file_data = &read_bytes($compressed_file, $file_size_compressed);
close $compressed_file;

my @compressed_file_data_array = split(//, $compressed_file_data);

&append_bytes(\@compressed_file_data_array, $target_file);

unlink "$target_file\.TEMP";

print "Uncompressed Source File: $source_file ($file_size_uncompressed bytes)\n";
print "Compressed Target File: $target_file ($file_size_compressed bytes + 12 byte header)\n";

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

	for(1 .. 8 - length($_[0]))
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

	$byte_array_reversed[0] = $byte_array[6];
	$byte_array_reversed[1] = $byte_array[7];
	$byte_array_reversed[2] = $byte_array[4];
	$byte_array_reversed[3] = $byte_array[5];
	$byte_array_reversed[4] = $byte_array[2];
	$byte_array_reversed[5] = $byte_array[3];
	$byte_array_reversed[6] = $byte_array[1];
	$byte_array_reversed[7] = $byte_array[0];

	return join('', @byte_array_reversed);
}