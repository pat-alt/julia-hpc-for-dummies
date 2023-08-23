import MPI
MPI.Init()

# Utility functions
include("utils.jl");

comm = MPI.COMM_WORLD                               # Collection of processes that can communicate in our world 🌍
rank = MPI.Comm_rank(comm)                          # Rank of this process in the world 🌍
n_processes = MPI.Comm_size(comm)                   # Number of processes in the world 🌍

nobs = [10^i for i in 1:10]                         # Number of observations to simulate
N_counts = split_count(length(nobs), n_processes)   
_start = rank == 0 ? 1 : cumsum(N_counts)[rank] + 1 # Start index for this process
_stop = _start + N_counts[rank + 1] - 1
chunk = nobs[_start:_stop]                          # Chunk of nobs to simulate

nobs_local = MPI.scatter(chunk, comm)               # Scatter nobs to all processes

println("rank = $(rank), chunk = $(nobs_local)\n")

MPI.Barrier(comm)                                   # Wait for all processes to reach this point

println("P$(MPI.Comm_rank(comm)) behind barrier 🚧.\n")

MPI.Finalize()