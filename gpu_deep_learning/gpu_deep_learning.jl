using MPI
MPI.Init()

using Pkg
Pkg.activate(@__DIR__)
Pkg.resolve()
Pkg.instantiate()

using CUDA
println("CUDA is functional: ", CUDA.functional())

MPI.Finalize()