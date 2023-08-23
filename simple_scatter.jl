import MPI
MPI.Init()

# Utility functions
include("utils.jl");

comm = MPI.COMM_WORLD                               # Collection of processes that can communicate in our world 🌍
rank = MPI.Comm_rank(comm)                          # Rank of this process in the world 🌍
n_proc = MPI.Comm_size(comm)                        # Number of processes in the world 🌍

nobs = [10^i for i in 1:10]                         # Number of observations to simulate
group_indices = split_obs(nobs, n_proc)             # Split nobs into groups of approximately equal size

nobs_local = MPI.scatter(group_indices, comm)       # Scatter nobs to all processes

println("rank = $(rank), chunk = $(nobs_local)\n")

MPI.Barrier(comm)                                   # Wait for all processes to reach this point

println("P$(MPI.Comm_rank(comm)) behind barrier 🚧.\n")

MPI.Finalize()