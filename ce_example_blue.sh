#!/bin/bash

#SBATCH --job-name="Counterfactuals"
#SBATCH --time=00:10:00
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation

module load 2023rc1 openmpi julia

srun julia hello_mpi.jl > hello_mpi.log