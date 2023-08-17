#!/bin/bash
#
#SBATCH --job-name="Julia on GPU"
#SBATCH --partition=gpu
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
# SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --account=innovation

module load 2022r2 openmpi julia
module load 2022r2
module load cuda/12.1

srun julia gpu_dl.jl > gpu_dl.log
