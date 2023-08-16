#!/bin/bash
#
#SBATCH --job-name="gpu_deep_learning.jl"
#SBATCH --partition=gpu
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
# SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --account=innovation

module load 2023r1 openmpi julia
module load 2023r1
module load cuda/12.1

srun julia gpu_deep_learning.jl > gpu_deep_learning.log