#!/bin/bash

#SBATCH --job-name="Multi-threading"
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation
#SBATCH --mail-type=END     # Set mail type to 'END' to receive a mail when the job finishes. 

source examples/slurm_header.sh

srun julia --project=examples --threads $SRUN_CPUS_PER_TASK examples/multi_threading.jl > examples/multi_threading.log
