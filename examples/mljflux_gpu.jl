using MLJ
using MLJFlux
import RDatasets
iris = RDatasets.dataset("datasets", "iris");
y, X = unpack(iris, ==(:Species), colname -> true, rng=123);
X = Float32.(X)
model = @load NeuralNetworkClassifier pkg=MLJFlux

warmup = NeuralNetworkClassifier()
clf = NeuralNetworkClassifier(epochs=1000)
clf_gpu = NeuralNetworkClassifier(acceleration=CUDALibs(), epochs=1000)

# Warm up:
machine(warmup, X, y) |> x -> fit!(x; verbosity=1)

@info "Training on CPU:"
@time machine(clf, X, y) |> fit!

@info "Training on GPU:"
@time machine(clf_gpu, X, y) |> fit!