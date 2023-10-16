set -x                                                  # keep log of executed commands
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"        # assign extra environment variable to be safe 
export OPENBLAS_NUM_THREADS=1                           # avoid that OpenBLAS calls too many threads