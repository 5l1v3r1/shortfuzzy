#Short Fuzzy Rat,was inspired by Luca "ikki" Carettoni and his Fuzzing List with 879 attack vectors, 8 levels of recursion (Unix-like, Windows)
#initially this hack was my x1bweb(serrated) web vuln scanner with A fuzzing option included(to fuzz any confirmed scripts on the host),but I figure many are still learning what Fuzzing is,so as 'ikki' 
#has provided his list,I will code a fuzzer to compliment it. I've included http/1.0 methods to add to the fuzzing options. personally i'm no fan of Web Server attacks as it seems mindless to focus ones
#attention on 1 (port 80) of 65535 ports or at least 1026 known possible services to explore,learn,write code for to exploit,and...well..exploit it!  it's 4am and I sit here baring this wry grin on my
#face,coffee in hand and thinking 'man I miss doing this..'

#shoutz to #suidrewt and props to Betrayed,MLS577,The Wade,LycanDarko,ryoh,Bryno,Obscure,Magic,KillaB,Aviator753,etc

#!/usr/bin/perl
print<<__MENU;
--------------------------------------------------------------------------------
                          Short.Fuzzy.Rat Alpha0.1
                  
                           written by: ratdance    
__MENU
print qq(-------------------------------------------------------------------------------\n);
print qq(Hosts List:\t);

use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;
my $time = localtime(time);
my $def = new LWP::UserAgent;
my ($hostdb,$host,$userresp,$url,$response,$request,$vulndb,$vuln,$fuzz);
my $ua = LWP::UserAgent->new(agent => "Log", env_proxy => 1, keep_alive => 1,timeout => 1);
my @hosts;
my @vdbs;
my @fuzz;
my @database=("http://HOST/FUZZ/\n");


 

$hostdb = <STDIN>;
chomp($hostdb);
open(IN, $hostdb) or die "unable to locate $hostdb";

@hosts = <IN>;
chomp(@hosts);

print qq(fuzz List:\t);
$fuzz = <STDIN>;

print qq(http/1.1 method:\t);
$method = <STDIN>;


chomp($fuzz);
open(FDB, $fuzz) or die "unable to locate a $fuzz";

@fuzz = <FDB>;
chomp(@fuzz);

print qq(--------------------------------------------------------------------------------\n);
print qq(\n               Fuzzing Initiated @ $time                                      \n);

foreach $host (@hosts){
foreach $fuzz (@fuzz) {	
foreach (@database)   {

$url = $_;
$url =~ s/VDB/$vuln/;
$url =~ s/FUZZ/$fuzz/;
$url =~ s/HOST/$host/;


print qq(\n::Querying $url\n);
my $request = new HTTP::Request($method,$url);
my $response = $def->request($request);
if ($response->is_success) {
print $response->decoded_content;


open(OUT, ">>Log");
print OUT $time," ",$url;
close OUT;
} else {
}
}
}
}
print qq(--------------------------------------------------------------------------------\n);
print qq(\n               Short.Fuzzy.Rat Completed @ $time                                \n);
print qq(--------------------------------------------------------------------------------\n);
print qq(                       Hit [enter] to exit                                        );
<>

