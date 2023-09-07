#!/bin/bash

#SBATCH --job-name="Counterfactuals"
#SBATCH --time=00:15:00
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation

module load 2023r1 openmpi julia

srun julia --project ce_example.jl > ce_example.log
