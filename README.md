# variant_annotation

##overview of the task
For this task, I used existing program "SnpEff" to conduct the effect predicition 
using vcf file as input. Then I wrote a small piece of perl script to parse the desired 
information and generate the output csv file. The allele frequency in population level is still missing.
I haven't done that before and it will have to take a bit more time for me to figure out.

##contents in the folder
This folder contains three files: "README.md", "parse_annotation.pl", "output.csv". "parse_annotation.pl" and 
"output.csv" contain the perl script and final output file, respectively.

##comamnd line for the task
##The computing works are conducted using high-performed computing cluster with Linux system

#step_1 annotate the vcf file using SnpEff(http://pcingola.github.io/SnpEff/)

#load jdk module on cluster
module load jdk/1.8.0_171

#run SnpEff using human genome GRCh37 as reference to match vcf file.  
bsub -n 3 -R span[hosts=1] -q interactive -R rusage[mem=2048] -W 0:20 -Is java -jar snpEff.jar GRCh37.75 \
./variant_data.vcf -no-downstream -no-upstream > output.vcf

#step_2 using perl to parse annotation and generate csv file.
parse_annotation.pl output.vcf > annotated_variation.csv




