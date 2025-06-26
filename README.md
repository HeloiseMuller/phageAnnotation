# Phage Annotation

## Introduction
This pipeline runs VS2 + checkV + VS2 again, and generate a file that contains information from all these outputs. It also filters phages.

## Citation
Please cite our paper "Genetic exchange networks bridge mobile DNA vehicles in the bacterial pathogen Listeria monocytogenes"  by Muller et al.  (Publication to come)

## Requirements
- [R](https://cran.r-project.org) 4.3+ with the following packages:
  - [data.table](https://cran.r-project.org/web/packages/data.table/) 1.16.2
  - [stringi](https://cran.r-project.org/web/packages/stringi/) 1.8.4
  - [dplyr](https://cran.r-project.org/web/packages/dplyr/) 1.1.4

  (If not found, these packages are installed automatically by the pipeline.) 

- [virsorter2](hhttps://github.com/jiarong/VirSorter2) 
- [checkV](https://anaconda.org/bioconda/checkv)

The pipeline was not tested with other versions of the above programs, but other versions probably work.  

## Installation
In a bash-compatible terminal that can execute git, paste
```
git clone https://github.com/HeloiseMuller/phageAnnotation.git
cd phageAnnotation/
```

## STEP 1: run VS2 + checkV + VS2
This pipeline has been written to run this first step on a slurm server.
TO COMPLETE


## STEP 2: Combine all outputs
```
cat */vs2-pass1/*_final-viral-boundary.tsv > allOutputs_vs2-pass1_final-viral-boundary.tsv
cat */checkv/contamination_named.tsv > allOutputs_contamination_named.tsv
cat */vs2-pass2/*_final-viral-score.tsv > allOutputs_vs2-pass2_final-viral-score.tsv
cat */vs2-pass2/*_final-viral-combined.fa > allOutputs_vs2-pass2_final-viral-combined.fa
```
All these combined files can be copied on a personal machine at this step.

## STEP 3: Run the R script that harmonizes these outputs

To see all options run:
```
Rscript phageAnnotation.R -h
```

The following command line runs the script using the optional -w argument (allowing to get the coordinates of the phage sequences in the genome), filter out sequences shorter than 5000 bp and sequences that do not pass at least one of the three tuning removal rule.
```
Rscript phageAnnotation.R -c -allOutputs_contamination_named.tsv-v  allOutputs_vs2-pass2_final-viral-score.tsv -f 1 -l 5000 -w allOutputs_vs2-pass1_final-viral-boundary.tsv
```

## STEP 4 (optional): Remove filtered phages from fasta
```
seqtk subseq allOutputs_vs2-pass2_final-viral-combined.fa  phages_filtered_5000bp_AND_3TuningRemoval.lst > phages_filtered.fasta
```

## Output description of XX.sh

## Output description of XX.R



