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

- [ncbi blast+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download) 2.14.0
- [python3]

The pipeline was not tested with other versions of the above programs, but other versions probably work.  

## Installation
In a bash-compatible terminal that can execute git, paste
```
 git clone git@github.com:HeloiseMuller/phageAnnotation/
 cd phageAnnotation/
```

## STEP 1: run VS2 + checkV + VS2
This pipeline has been written to run this first step on a slurm server.

## STEP 2: Combine all outputs
```
cat */checkv/contamination_named.tsv > allOutputs_contamination_named.tsv
cat */vs2-pass2/*_final-viral-score.tsv > allOutputs_vs2-pass2_final-viral-score.tsv
cat */vs2-pass2/*_final-viral-combined.fa > allOutputs_vs2-pass2_final-viral-combined.fa
```

## STEP 3: Run the R script that harmonizes these outputs
`allOutputs_contamination_named.tsv` and ` allOutputs_vs2-pass2_final-viral-score.tsv` can be copies on a personal machine at this step.

```
Rscript ViralAnnotation.R -c all_936SRR_clean_contamination_named.tsv -v all_936SRR_clean_vs2-pass2_final-viral-score.tsv -f 1 -l 5000
```

## STEP 3 (optional): Remove filtered phages from fasta
`seqtk subseq allOutputs_vs2-pass2_final-viral-combined.fa test/filtering/phages_filtered.lst > phages_filtered.fasta`

#COORD IN GENOME?

## Output description of XX.sh

## Output description of XX.R



