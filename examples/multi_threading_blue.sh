#!/bin/bash

#SBATCH --job-name="Multi-threading"
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation
#SBATCH --mail-type=END     # Set mail type to 'END' to receive a mail when the job finishes. 

module load 2023r1 openmpi julia

export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"

srun julia --project --threads 8 multi_threading.jl > multi_threading.log
