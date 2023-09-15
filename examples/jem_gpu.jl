using Distributions
using JointEnergyModels
using MLJ
using MLJFlux

X, y = make_blobs(100, 3; centers=2, cluster_std=[1.0, 3.0])
Xmat = Float32.(permutedims(MLJ.matrix(X)))
X = MLJ.table(permutedims(Xmat))
model = @load NeuralNetworkClassifier pkg = MLJFlux

𝒟x = Normal()
𝒟y = Categorical(ones(2) ./ 2)
sampler = ConditionalSampler(𝒟x, 𝒟y, input_size=size(Xmat)[1:end-1], batch_size=batch_size)
clf = JointEnergyClassifier(
    sampler;
    builder=MLJFlux.MLP(hidden=(32, 32, 32,), σ=Flux.relu),
    batch_size=batch_size,
    finaliser=x -> x,
    loss=Flux.Losses.logitcrossentropy,
    acceleration=CUDALibs(),
)
mach = machine(clf, X, y) |> fit!