#!/bin/bash

#SBATCH --job-name="Multi-threading"
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation
#SBATCH --mail-type=END     # Set mail type to 'END' to receive a mail when the job finishes. 

module load 2023r1 julia

export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"

srun julia --project=examples --threads 1 examples/multi_threading.jl > multi_threading.log
