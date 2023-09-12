using MLJ
using MLJFlux
import RDatasets
iris = RDatasets.dataset("datasets", "iris");
y, X = unpack(iris, ==(:Species), colname -> true, rng=123);
X = Float32.(X)
model = @load NeuralNetworkClassifier pkg=MLJFlux

# Warm up:
warmup = NeuralNetworkClassifier()
warmup_gpu = NeuralNetworkClassifier(acceleration=CUDALibs())
machine(warmup, X, y) |> fit!
machine(warmup_gpu, X, y) |> fit!

# Benchmark:
clf = NeuralNetworkClassifier(epochs=1000)
clf_gpu = NeuralNetworkClassifier(acceleration=CUDALibs(), epochs=1000)

@info "Training on CPU:"
@time machine(clf, X, y) |> fit!

@info "Training on GPU:"
@time machine(clf_gpu, X, y) |> fit!