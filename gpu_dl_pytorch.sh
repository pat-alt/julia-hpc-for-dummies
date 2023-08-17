#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --mem=8G
#SBATCH --time=10 # default in minutes
#SBATCH --account=innovation

module load 2022r2 openmpi py-torch

srun python test_pytorch_gpu.py
