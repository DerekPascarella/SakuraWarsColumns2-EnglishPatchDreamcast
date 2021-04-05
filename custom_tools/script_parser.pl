#!/usr/bin/perl
#
# Written by Derek Pascarella (ateam)
#
# Sakura Wars: Columns 2
# Script Parser/Extractor

$file_name = $ARGV[0];

chop($file_content = `cat $file_name`);

@split = split(/( [A-Z])/, $file_content);

foreach(@split)
{
	if(length($_) == 2)
	{
		next;
	}

	@split2 = split(/\#/, $_);

	for($i = 0; $i <= $#split2; $i ++)
	{
		$split2[$i] =~ s/\/.*//;

		if($i == 0)
		{
			print "[$split2[$i]]\n";
		}
		else
		{
			print "$split2[$i]";
		}
	}

	print "\n\n";
}
