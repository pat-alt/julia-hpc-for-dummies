using Pkg; Pkg.activate(@__DIR__)

using BenchmarkTools
using CUDA
using FastAI
using FastVision
using Metalhead

# Check that CUDA is functional:
println("CUDA is functional: ", CUDA.functional())
