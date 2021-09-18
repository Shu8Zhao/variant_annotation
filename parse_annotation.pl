#!/usr/bin/perl 
use strict;

#initial variants
my @input_vcf;
my @output_csv;

#open gene file                                      
@input_vcf = openfile_array($ARGV[0]); 

#make annotation for each variant site
foreach my $input_vcf_line(@input_vcf){
#skip the annotation lines in vcf file
if ($input_vcf_line=~/^#/){
next;
}else{
my $new_line= make_newline($input_vcf_line);
push (@output_csv, $new_line);
}
}
shift @output_csv;
unshift (@output_csv,'CHR,LOC,REF,ALT,TYPE,DP,AO,RO,AO/RO,Eff'."\n");
 
print @output_csv;

#################subroutines#####################
#open array file
sub openfile_array {
  my $filename= $_[0];
  unless (open(FILE, $filename)){
  print "cannot find the file \"$filename\"!!!";
  }
  open (FILE, $filename);
  my @data=<FILE>;
  close FILE;
  return @data;
}

#generate new line parse each annotation
sub make_newline {
 my $input_line= $_[0];
 $input_line=~/TYPE=([A-Za-z]*);/;
 my $type=$1;
 $input_line=~/;DP=([0-9]*);/;
 my $DP=$1;
 $input_line=~/;AO=([0-9]*);/;
 my $AO=$1;
 $input_line=~/;RO=([0-9]*);/;
 my $RO=$1;
 my $ratio_AR="$AO\/$RO";
 $input_line=~ /ANN=[^\|]+\|([^\|]+)\|/;
 my $efffect=$1;

 my @input_line= split(/\s/,$input_line);
 my $output_line= $input_line[0].",".$input_line[1].",".$input_line[3].",".$input_line[4].",".$type.",".$DP.",".$AO.",".$RO.",".$ratio_AR.","."$efffect"."\n";

 return $output_line;

}
