#!/bin/bash
#SBATCH -n 1
#SBATCH --partition=batch
#SBATCH --cpus-per-task=18
#SBATCH --mem=64G
#SBATCH -o /network/rit/lab/andamlab/Heloise/project_Listeria/viralAnnotation/phageAnnotation-slurm-%j.out
#SBATCH -D /network/rit/lab/andamlab/Heloise/project_Listeria/  # working directory
#SBATCH -v

#SBATCH --array=3-458%4

bash phageAnnotation_array.sh $SLURM_ARRAY_TASK_ID genomesPath outputsPath dataset.lst pathDB