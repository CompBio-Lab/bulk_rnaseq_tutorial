#!/bin/bash

#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --mem=64gb
#SBATCH --account=st-singha53-1
#SBATCH --job-name=run_fastqc_trim
#SBATCH --mail-user=amrit.singh@ubc.ca
#SBATCH --output=%x-%j.log


#############################################################################

module load apptainer

DATA=/scratch/st-wang85-1/singha53/bulk_rnaseq/results/trim

cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_DIR
apptainer run -B $DATA /scratch/st-wang85-1/singha53/bulk_rnaseq/data/bulk_rnaseq.sif make fastqc_trim