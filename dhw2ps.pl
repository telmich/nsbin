#!/usr/bin/env perl

# -------------------------------------------------------------------------
# file:		dhw2ps.pl
# task:		convert the internal dwh file format of DigiMemo A501 to
#		ps or pdf files
# authors:	Jan Theofel (theofel@etes.de)
#		Harald Koenig
# version:	0.1
# license:	free to use, an official license will follow
# -------------------------------------------------------------------------
# TODO:
# - code cleanup
# - code optimisation (the array of chars is very slow)
# - adding a real license
# - add documentation
# -------------------------------------------------------------------------

use strict;
use Getopt::Long qw(:config gnu_getopt);

my $pdfout = ($0 =~ /dhw2pdf/);;
my $debug = 0;
my $verbose = 0;
my $usage = 0;
my $quiet = 0;
my $colorlayers = 0;

sub usage
{
  print "usage: $0 [params] [dwh file(s)]\n\n";
  print "Where params can be:\n";
  print "-c|--colorlayers     color layers\n";
  print "-d|--debug           run in debug mode\n";
  print "-h|--help            display this usage message\n";
  print "-q|--quiet           run in quite mode\n";
  print "-v|--verbose         run in verbose mode\n";
  print "--pdf                create pdf files (nneds ps2pdf)\n";
  print "--ps                 create ps files\n"; 
  exit $_[0];
}

GetOptions (
	    'c' => \$colorlayers, 'colorlayers!' => \$colorlayers,
	    'd' => \$debug,       'debug!'       => \$debug,
	    'h' => \$usage,       'help'         => \$usage,
	    'q' => \$quiet,       'quiet!'       => \$quiet,
	    'v' => \$verbose,     'verbose!'     => \$verbose,
	    'pdf!' => \$pdfout,
	    'ps!'  => sub { $pdfout = 0 },
	    ) or usage(1);

my $inname = shift();

usage(0) if ($usage || !$inname);

if ($pdfout) 
{
  my $check_ps2pdf = `which ps2pdf`;
  if($check_ps2pdf eq "")
  {
    die "ERROR: ps2pdf is needed in pdf mode.\n";
  }
}


while ($inname) { # loop for all input files

    my ($buffer, $skip, $data);
    my ($fileversion, $paperwidth, $paperheight, $paperformat);
    my $file_content;



    print "INFO: input file: $inname\n" if (!$quiet);
    open(IN, "$inname");

    my $count = 32;
    read(IN, $data, $count);

    if($data ne "ACECAD_DIGIMEMO_HANDWRITING_____") {
	die "Invalid INK file $inname\n";
    }

# read rest of input file in 64K junks
    while(read(IN, $buffer, 64*1024)) {
	$data .= $buffer;
    }
    close(IN);

    my @data = split(//, $data);


# decode header data

    $fileversion = ord($data[$count++]);
    
    $paperwidth = ord($data[$count+0]) + (ord($data[$count+1]) << 8);
    $count += 2;

    $paperheight = ord($data[$count+0]) + (ord($data[$count+1]) << 8);
    $count += 2;

    my $pagetype = ord($data[$count++]);

    ord($data[$count++]);  # skip header byte
    ord($data[$count++]);  # skip header byte

    my $paper = ("a5", "a4", "??2", "??3", "??4", "??5", "??6", "??7", "b5", "b4")[$pagetype];
    my $orientation = ("Portrait", "Landscape")[ $paperheight < $paperwidth ];

    my $llx = 0;  #  87  for A4 centering on A4
    my $lly = 0;  # 123  for A4 centering on A4
    my $urx = $llx + int($paperwidth  / 1000. * 72. + 0.999999);
    my $ury = $lly + int($paperheight / 1000. * 72. + 0.999999);

    my $now = gmtime;

    print "DEBUG: ink file version: $fileversion\n" if ($debug);
    print "DEBUG: width / height: $paperwidth / $paperheight\n" if ($debug);
    print "DEBUG: pagetype: $pagetype ($paper)\n" if ($debug);


    my $outfile;

    if ($pdfout) {
	$outfile = "|ps2pdf -sPAPERSIZE=$paper - $inname";
	$outfile =~ s/\.dhw$//;
	$outfile .= ".pdf";
    } else {
	$outfile = ">$inname";
	$outfile =~ s/\.dhw$//;
	$outfile .= ".ps";
    }

    print "DEBUG: output file: $outfile\n" if ($debug);
    open(OUT, "$outfile");


    print OUT <<PSHEAD;
    %!PS-Adobe-2.0
	%%Title: $inname
	%%Creator: ink2ps $inname
	%%CreationDate: $now
	%%Orientation: $orientation
	%%BoundingBox: $llx $lly $urx $ury
	%%DocumentPaperSizes: $paper
	%%Pages: 1
	%%EndComments
	/StartPage {
	    gsave
		$llx $lly translate
		72 1000 div dup scale
		1 setlinecap
		1 setlinejoin
		1 LW
	    } bind def
	    /EndPage {
		grestore
		    showpage
		} bind def
		/RGB { setrgbcolor } bind def
		/LW { setlinewidth } bind def
		/S { newpath moveto } bind def
		/L { lineto } bind def
		/E { stroke } bind def
		%%EndProlog
		%%Page: 1 1
		StartPage

		% set line width
		16 LW

		% set color
		0 0 0 RGB

		% strokes
PSHEAD


    my $color     = 0;
    my $lastcolor = 0;
    my $layer     = 0;
    my $strokes   = 0;
    my $points    = 0;
    my $pointcmd  = "S";
    
    while($count < $#data) {
	my $next = ord($data[$count++]);

	if (($next & ~0x07) == 0x80) {  # pen up/down
	    if ($next & 0x01) {
		$pointcmd = "S";
		print "DEBUG pen down POSITION $count\n" if ($debug);
	    }
	    else {
		$pointcmd = "L\nE\n";
		$strokes++;
		print "DEBUG pen up POSITION $count\n" if ($debug);
	    }

	    $color = (($next >> 1) + ($layer * $colorlayers))  & 0x03;
	    print "DEBUG pen color $color\n" if ($debug);
	    if ($color != $lastcolor) {
		$lastcolor = $color;
		print OUT "%%Color: $color\n";
		print OUT ("0 0 0", "1 0 0", "0 1 0", "0 0 1")[$color] . " RGB\n";
	    }
	}
	elsif ($next == 0x88) {  # time stamp
	    my $timestamp = ord($data[$count++]);
	    print "DEBUG TimeStamp $timestamp\n" if ($debug);
	    print OUT "%%TimeStamp: $timestamp\n" if ($timestamp < 0x7f);
	}
	elsif ($next == 0x90) {  ## end of layer
	    $layer = ord($data[$count++]);
	    print "DEBUG End of LAYER $layer\n" if ($debug);
	    die("Layer # $layer > 127") if ($layer & 0x80);
		print OUT "%%EndOfLayer: $layer\n\n";
	}
	elsif (!($next & ~0x7f)) {  ## coordinates
	    my ($b1, $b2, $b3, $b4) = ($next, ord($data[$count+0]), ord($data[$count+1]), ord($data[$count+2]));
	    $count += 3;
	    printf "DEBUG CHECK position $count A %02x %02x %02x %02x\n", $b1, $b2, $b3, $b4 if ($debug);
	    # die("MSB set in coordinate bytes") if (($b1 | $$b2 | $b3 | $b4) & ~0x7f);

	    my $x = $b1 + ($b2 << 7);
	    my $y = $b3 + ($b4 << 7);
	    print "DEBUG $count: x = $x / y = $y\n" if ($debug);
	    print OUT "$x $y " . $pointcmd . "\n";
	    $points++;

	    $pointcmd = "L";
	} else {
	    die("unknown byte " . sprintf("0x%02x", $next) . " at position $count");
	}
    }

    print OUT <<PSFOOT;

    EndPage
	%%Trailer
	%%EOF
PSFOOT

    close(OUT);

    print "INFO: $points points, $strokes strokes, $layer layers\n\n" if (! $quiet);

    $inname = shift();
}
