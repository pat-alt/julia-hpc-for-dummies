using Pkg
Pkg.activate(@__DIR__)
println(Pkg.status())
Pkg.resolve()
Pkg.instantiate()

using BenchmarkTools
using CUDA
using FastAI
using FastVision
using FastMakie
using Metalhead
import CairoMakie

# Check that CUDA is functional:
println("CUDA is functional: ", CUDA.functional())
CUDA.functional() || break

# Get data:
ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"              # avoid command prompt and just download
data, blocks = load(datarecipes()["mnist_sample"])
train_data, _ = splitobs(data, at=1000)             # small sample to speed up training

# Set up learners:
task = ImageClassificationSingle(blocks)
bs = 100
gpu_learner = tasklearner(task, train_data, callbacks=[ToGPU(), Metrics(accuracy)], backbone=ResNet(18).layers[1:end-1], batchsize=bs)
cpu_learner = tasklearner(task, train_data, callbacks=[Metrics(accuracy)], backbone=ResNet(18).layers[1:end-1], batchsize=bs)

@info "Training on CPU:"
@btime lrfind(cpu_learner)

@info "Training on GPU:"
@btime lrfind(gpu_learner)


