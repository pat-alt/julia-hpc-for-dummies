# examples/02-broadcast.jl
import MPI
MPI.Init()

comm = MPI.COMM_WORLD                       # Collection of processes that can communicate in our world 🌍
rank = MPI.Comm_rank(comm)                  # Rank of this process in the world 🌍
n_processes = MPI.Comm_size(comm)           # Number of processes in the world 🌍

nobs = [10^i for i in 1:n_processes]        # Number of observations to simulate


idx = rank + 1                              # Index of nobs to use for this process
nobs_rank = nobs[idx]                       # Number of observations to simulate for this process
val = sum(randn(nobs_rank)) / nobs_rank     # Simulate some data and compute the mean

println("rank = $(rank), nobs = $(nobs_rank), val = $(val)\n")

MPI.Barrier(comm)                           # Wait for all processes to reach this point

println("P$(MPI.Comm_rank(comm)) behind barrier 🚧.\n")

MPI.Finalize()