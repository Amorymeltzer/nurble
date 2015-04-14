#!/usr/bin/env perl
# nurbler.pl by Amory Meltzer
# Nurblenurblenurglenurble
# http://www.smbc-comics.com/?db=comics&id=2779
# http://wordlist.sourceforge.net/


use strict;
use warnings;
use diagnostics;

unless (@ARGV == 2)
  {
    print "Usage: $0 <part_of_speech.txt> <file_to_nurble.txt>/n";
    exit;
  }

my $output = 'nurbled_text.txt';


# Part of speech lookup
my %speech;
open my $pos, '<', "$ARGV[0]" or die $!;
while (<$pos>) {
  chomp;
  my @tmp = split /\t/;
  $tmp[1] =~ s/\|//go;		# get rid of | character
  $speech{$tmp[0]} = $tmp[1];
}
close $pos or die $!;

#open (my $new, ">$output") or die $!; # output nurbled text
open my $old, '<', "$ARGV[1]" or die $!;
while (<$old>) {
  chomp;
  my @tmp = split /\s/;
  #print "@tmp\n";

  for my $i (0..(scalar @tmp - 1)) {
    #print "\t$tmp[$i]\n";
    if (($speech{$tmp[$i]}) && ($speech{$tmp[$i]} =~ m/^N/i)) {
      print "$tmp[$i] ";
      #print "\n$tmp[$i]\t$speech{$tmp[$i]}\n\n";
    } else {
      print 'nurble ';
    }
  }
  print "\n";			# restore some semblance of formating
}
close $old or die $!;
