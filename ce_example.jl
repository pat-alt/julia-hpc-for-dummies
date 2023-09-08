using MPI
MPI.Init()

using CounterfactualExplanations
using CounterfactualExplanations.Data
using CounterfactualExplanations.Evaluation: benchmark
using CounterfactualExplanations.Models
using CounterfactualExplanations.Parallelization
using Logging
using Serialization

if MPI.Comm_rank(MPI.COMM_WORLD) != 0
    global_logger(NullLogger())
else
    @info "Disabling logging on non-root processes."
end

@info "An example of using CounterfactualExplanations.jl with MPI."

counterfactual_data = load_linearly_separable(1000)
M = fit_model(counterfactual_data, :Linear)
generator = GenericGenerator()

parallelizer = MPIParallelizer(MPI.COMM_WORLD)

bmk = with_logger(NullLogger()) do
    benchmark(counterfactual_data; parallelizer=parallelizer, n_individuals=5)
end

# Benchmarking:
n = 600

@info "Benchmarking with MPI"
time_mpi = @elapsed with_logger(NullLogger()) do
    global bmk = benchmark(counterfactual_data; parallelizer=parallelizer, n_individuals=n)
end

@info "Benchmarking without MPI"
time_wo = @elapsed with_logger(NullLogger()) do
    benchmark(counterfactual_data; parallelizer=nothing, n_individuals=n)
end

Serialization.serialize("ce_mpi_benchmark.jls", bmk)
time_bmk = Dict(
    :time_mpi => time_mpi,
    :time_wo => time_wo,
    :n => n,
    :n_cores => MPI.Comm_size(MPI.COMM_WORLD),
)

MPI.Barrier(MPI.COMM_WORLD)

if MPI.Comm_rank(MPI.COMM_WORLD) == 0
    @info "Benchmarking results"
    @info "Time with MPI: $(round(time_mpi)) seconds."
    @info "Time without MPI: $(round(time_wo)) seconds."
    @info "Speedup: $(time_wo / time_mpi)"
    @info "Number of individuals: $(n)"
    @info "Number of cores: $(MPI.Comm_size(MPI.COMM_WORLD))"
    @info "Benchmarking results saved to ce_mpi_benchmark.jls"
end

Serialization.serialize("ce_mpi_benchmark_times.jls", time_bmk)
MPI.Finalize()
