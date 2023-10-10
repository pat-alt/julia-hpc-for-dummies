#!/bin/bash

#SBATCH --job-name="hello_mpi.jl"
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=5
#SBATCH --cpus-per-task=1
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation

module load 2023rc1 openmpi
set -x

export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"

srun julia --project=examples --threads $SRUN_CPUS_PER_TASK examples/hello_mpi.jl > hello_mpi.log
