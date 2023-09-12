using CUDA
using cuDNN
using FastAI
using FastVision
using Metalhead

# Get data:
ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"              # avoid command prompt and just download

# Check that CUDA is functional:
println("CUDA is functional: ", CUDA.functional())

if CUDA.functional()
    
    data, blocks = load(datarecipes()["mnist_sample"])
    train_data, _ = splitobs(data, at=1000)             # small sample to speed up training

    # Set up learners:
    task = ImageClassificationSingle(blocks)
    bs = 100
    gpu_learner = tasklearner(task, train_data, callbacks=[ToGPU(), Metrics(accuracy)], backbone=ResNet(18).layers[1:end-1], batchsize=bs)
    cpu_learner = tasklearner(task, train_data, callbacks=[Metrics(accuracy)], backbone=ResNet(18).layers[1:end-1], batchsize=bs)
    warm_up_learner = deepcopy(cpu_learner)

    # Warm up:
    finetune!(warm_up_learner, 1)

    # Benchmark:
    @info "Training on CPU:"
    @time finetune!(cpu_learner, 3)

    @info "Training on GPU:"
    @time finetune!(gpu_learner, 3)
else 
    @info "Terminating."
end


