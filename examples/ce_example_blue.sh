#!/bin/bash

#SBATCH --job-name="Counterfactuals"
#SBATCH --time=00:20:00
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=4
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=4GB
#SBATCH --account=innovation
#SBATCH --mail-type=END     # Set mail type to 'END' to receive a mail when the job finishes. 

module load 2023rc1 openmpi

source examples/slurm_header.sh

srun julia --project=examples --threads $SRUN_CPUS_PER_TASK examples/ce_example.jl > ce_example.log
