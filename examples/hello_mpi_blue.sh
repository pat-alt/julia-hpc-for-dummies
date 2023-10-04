#!/bin/bash

#SBATCH --job-name="hello_mpi.jl"
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation

module load 2023rc1 openmpi

export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"

srun julia --project hello_mpi.jl > hello_mpi.log
