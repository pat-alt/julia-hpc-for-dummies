import MPI
MPI.Init()

comm = MPI.COMM_WORLD                       # Collection of processes that can communicate in our world 🌍
rank = MPI.Comm_rank(comm)                  # Rank of this process in the world 🌍
n_processes = MPI.Comm_size(comm)           # Number of processes in the world 🌍

nobs = [10^i for i in 1:2n_processes]                               # Number of observations to simulate
num_per_process = length(nobs) ÷ n_processes
nobs_chunked = Base.Iterators.partition(nobs, num_per_process)      # Partition nobs into chunks of size n_processes

nobs_local = MPI.scatter(collect(nobs_chunked), comm)               # Scatter nobs to all processes

println("rank = $(rank), nobs = $(nobs_local)\n")

MPI.Barrier(comm)                           # Wait for all processes to reach this point

println("P$(MPI.Comm_rank(comm)) behind barrier 🚧.\n")

MPI.Finalize()