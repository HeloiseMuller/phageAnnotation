#!/bin/bash

#Argument 1 = array number
#Argument 2 = genomesPath
#Argument 3 = outputsPath
#Argument 4 = path to the file dataset.lst
#Argument 5 = path of checkV database

source /network/rit/lab/andamlab/bin/miniconda3/etc/profile.d/conda.sh
conda activate virsorter2
umask g+rwx

#Get the th line of the file dataset.lst
assembly=`sed "$1q;d" $4`

cd $3

input=`ls $2/${assembly}*_genomic.fna`

virsorter run --keep-original-seq -i  $input -w $assembly/vs2-pass1/ -j 18 all

#All means run the all pipeline

#Add assembly name to files
mv $assembly/vs2-pass1/final-viral-boundary.tsv $assembly/vs2-pass1/${assembly}_final-viral-boundary.tsv
mv $assembly/vs2-pass1/final-viral-combined.fa $assembly/vs2-pass1/${assembly}_final-viral-combined.fa
mv $assembly/vs2-pass1/final-viral-score.tsv $assembly/vs2-pass1/${assembly}_final-viral-score.tsv

awk -v var="$assembly" '{print $0, var}' OFS='\t' $assembly/vs2-pass1/${assembly}_final-viral-boundary.tsv  | grep -v seqname >  $assembly/vs2-pass1/${assembly}_final-viral-boundary_named.tsv

#Add name assembly in this fasta
sed "s/>/>${assembly}:/g"  $assembly/vs2-pass1/${assembly}_final-viral-combined.fa > $assembly/vs2-pass1/${assembly}_final-viral-combined_named.fa

conda activate checkV
checkv end_to_end $assembly/vs2-pass1/${assembly}_final-viral-combined_named.fa $assembly/checkv -t 18 -d $5
conda deactivate

cat $assembly/checkv/proviruses.fna $assembly/checkv/viruses.fna > $assembly/checkv/${assembly}_combined.fna

#We"re going to want to look at the contamination file
awk -v var="$assembly" '{print $0, var}' OFS='\t' $assembly/checkv/contamination.tsv | grep -v contig_id >  $assembly/checkv/contamination_named.tsv

virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -i $assembly/checkv/${assembly}_combined.fna -w $assembly/vs2-pass2 -j 18 all
mv $assembly/vs2-pass2/final-viral-combined.fa $assembly/vs2-pass2/${assembly}_final-viral-combined.fa
mv $assembly/vs2-pass2/final-viral-score.tsv $assembly/vs2-pass2/${assembly}_final-viral-score.tsv