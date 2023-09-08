#!/bin/bash

#SBATCH --job-name="Counterfactuals"
#SBATCH --time=00:20:00
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=8GB
#SBATCH --account=innovation
#SBATCH --mail-type=END     # Set mail type to 'END' to receive a mail when the job finishes. 

module load 2023r1 openmpi julia

srun julia --project ce_example.jl > ce_example.log
