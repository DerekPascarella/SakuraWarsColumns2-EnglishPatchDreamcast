#!/usr/bin/perl
#
# Written by Derek Pascarella (ateam)
#
# dialog_tester_and_encoder
# Simple webapp for testing "Sakura Wars: Columns 2" dialog lines to
# ensure they fit in the allotted space provided by dialog boxes.
# Page also outputs hex values for dialog text input, including new-
# line characters.

use CGI qw(:standard);
use String::HexConvert ':all';
use utf8;
use Text::Unidecode;
use URI::Encode qw(uri_encode uri_decode);
use strict;

my $mode = param('mode');
my $text = param('text');
my $text_for_form;
my $text_to_fold;

if($text ne "")
{
	$text = unidecode($text);	
	$text =~ s/^\s+|\s+$//g;
	$text =~ s/ +/ /;
	$text =~ s/’/'/g;
	$text =~ s/”/"/g;
	$text =~ s/“/"/g;

	$text_for_form = $text;
	$text_for_form =~ s/"/&quot;/g;

	$text_to_fold = $text;
	$text_to_fold =~ s/"/\\"/g;
}

my @fold;
my $errors = 0;
my $i;

print "Content-type: text/html\n\n";

print "
<html>
<head>
<title>Sakura Wars: Columns 2 - Dialog Text Limit Tester</title>
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
</head>
<body>
<center>
<table border=\"0\" width=\"500\">
<tr>
<td width=\"100%\">
<center>
<h1>Sakura Wars: Columns 2</h1>
<h2>Dialog Text Limit Tester</h2>
<br>
</center>
<form action=\"charlimit.pl\" mode=\"POST\">
<input type=\"hidden\" name=\"mode\" value=\"test\">
<label for\"text\">Text:</label>
<br>
<input type=\"text\" name=\"text\" id=\"text\" rows=\"5\" style=\"width: 100%\" value=\"$text_for_form\">
<br><br>
<center><i>Text must fit on 3 lines with 28 characters on lines 1 and 2, and 26 on line 3.</i></center>
<br>
<input type=\"submit\" value=\"Test\" style=\"width: 100%\">
</form></td>
</tr>
</table>
<br>
<table border=\"0\" width=\"500\">
<tr>
<td width=\"100%\">
";

if($mode eq "test")
{
	chop(@fold = `echo \"$text_to_fold\" | fold -w 28 -s`);

	if($#fold > 2)
	{
		foreach(@fold)
		{
			$_ =~ s/^\s+|\s+$//g;

			print "$_<br>\n";
		}

		print "<br><b>Error:</b> Too many lines (" . ($#fold + 1) . " total when only 3 is allowed).";

		$errors ++;
	}
	else
	{
		for($i = 0; $i <= $#fold; $i ++)
		{
			$fold[$i] =~ s/^\s+|\s+$//g;
	
			print "$fold[$i]";
	
			if($i > 1 && length($fold[$i]) > 26)
			{
				print "<br><br><b>Error:</b> Exceeded line 3's character count max. by " . (length($fold[$i]) - 26) . " (max. is 26).\n";

				$errors ++;
			}
			else
			{
				print "<br>\n";
			}
		}
	
		print "<br>\n";
	}

	if($errors == 0)
	{
		print "<b>Success, the text fits!</b>\n";		
	}
}

print "</td>
</tr>
</table>
";

if($errors == 0)
{
	print"
	<br><br>
	<b>Full hex conversion with carriage-returns</b>:
	<br>
	";

	if(scalar(@fold) == 1)
	{
		$fold[0] =~ s/^\s+|\s+$//g;

		print uc(ascii_to_hex($fold[0])) . "0A0A0A0A0A0A";
	}
	elsif(scalar(@fold) == 2)
	{
		$fold[0] =~ s/^\s+|\s+$//g;

		print uc(ascii_to_hex($fold[0])) . "0A";

		$fold[1] =~ s/^\s+|\s+$//g;

		print uc(ascii_to_hex($fold[1])) . "0A0A0A0A0A0A";
	}
	elsif(scalar(@fold) == 3)
	{
		$fold[0] =~ s/^\s+|\s+$//g;

		print uc(ascii_to_hex($fold[0])) . "0A";

		$fold[1] =~ s/^\s+|\s+$//g;

		print uc(ascii_to_hex($fold[1])) . "0A";

		$fold[2] =~ s/^\s+|\s+$//g;

		print uc(ascii_to_hex($fold[2])) . "0A0A0A0A0A0A";
	}

	for($i = 0; $i <= $#fold; $i ++)
	{
			
	}
}

print "
</center>
</body>
</html>
";
