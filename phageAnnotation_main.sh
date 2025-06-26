#!/bin/bash
#SBATCH -n 1
#SBATCH --partition=batch
#SBATCH --cpus-per-task=18
#SBATCH --mem=64G
#SBATCH -o /network/rit/lab/andamlab/Heloise/project_actinophages/viralAnnotation/annotVirus-slurm-%j.out
#SBATCH -D /network/rit/lab/andamlab/Heloise/project_actinophages/  # working directory
#SBATCH -v

#SBATCH --array=3-458%4


bash scripts/run_annotVirus_array.sh $SLURM_ARRAY_TASK_ID



