# examples/01-hello.jl
using MPI
MPI.Init()

comm = MPI.COMM_WORLD
println("Hello world, I am rank $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")
MPI.Barrier(comm)

println("P$(MPI.Comm_rank(comm)) behind barrier.")

MPI.Finalize()