#!/bin/bash

#SBATCH --job-name="Simple parallel loop"
#SBATCH --time=00:10:00
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation

module load 2023rc1 openmpi julia

srun julia simple_parallel_loop.jl > simple_parallel_loop.log