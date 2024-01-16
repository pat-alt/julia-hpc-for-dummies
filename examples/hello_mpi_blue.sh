#!/bin/bash

#SBATCH --job-name="hello_mpi.jl"
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=5
#SBATCH --cpus-per-task=4
#SBATCH --partition=compute
#SBATCH --mem-per-cpu=1GB
#SBATCH --account=innovation
#SBATCH --mail-type=END     # Set mail type to 'END' to receive a mail when the job finishes. 

module load 2023rc1 openmpi

source examples/slurm_header.sh

srun julia --project=examples --threads $SRUN_CPUS_PER_TASK examples/hello_mpi.jl > hello_mpi.log
