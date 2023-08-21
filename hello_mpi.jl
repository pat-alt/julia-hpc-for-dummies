using Pkg
Pkg.activate(@__DIR__)

using MPI
MPI.Init()

comm = MPI.COMM_WORLD
println("Hello world 🌍, I am rank $(MPI.Comm_rank(comm)) of world $(MPI.Comm_size(comm)).\n")
MPI.Barrier(comm)

println("P$(MPI.Comm_rank(comm)) behind barrier 🚪.\n")

MPI.Finalize()