# Julia on HPC for dummies

A loose collection of notes and example scripts that can be used for running Julia on an HPC. While the Julia examples should be applicable to any HPC, bash scripts may contain some details that are specific to the clusters owned and maintained by [Delft University of Technology](https://www.tudelft.nl/).

## Repo Structure

All notes are collected in this README file. Many of them are specific to working on one of the HPCs owned and maintained by [Delft University of Technology](https://www.tudelft.nl/). Code examples including Julia scripts and bash scripts (used to submit slurm jobs on clusters) are all contained inside the `examples/` folder. The `Project.toml` file inside the `examples/` folder specifies all necessary package dependencies. Any log files you may find contain the logs for specific examples. 

## Credit

Some of the examples you find here are either inspired or in some cases partially copied from [`MPI.jl`](https://juliaparallel.org/MPI.jl/latest/).

## Environment Configuration

This section contains notes that are not specific to any particular cluster. Anything related to general setup can be found in the [`examples/slurm_header.sh`](examples/slurm_header.sh) script.

### OpenBLAS thread calling

It is typically best to restrict the number of BLAS threads with `export OPENBLAS_NUM_THREADS=1`. 

### Data

If your project relies on data that is loaded from the web, then this will most likely be handled through the [DataDeps.jl](https://www.oxinabox.net/DataDeps.jl/stable/) package. For example, you might be interested in loading standard datasets from [MLDatasets.jl](https://github.com/JuliaML/MLDatasets.jl). That package depends on [DataDeps.jl](https://www.oxinabox.net/DataDeps.jl/stable/). In an interactive Julia session, users are by default prompted before data is actually downloaded. To bypass this on the cluster, the [`examples/slurm_header.sh`](examples/slurm_header.sh) specifies a special environment variable `export DATADEPS_ALWAYS_ACCEPT="true"`.

## Cluster-specific Notes

This section contains notes that are specific to the clusters owned and maintained by [Delft University of Technology](https://www.tudelft.nl/). While I am affiliated with TU Delft, I am not a cluster administrator but merely a user who primarily works with Julia. 

### Julia on DelftBlue

DelftBlue is one of the high-performance computers accessible to students and employees of TU Delft. It has farily extensive [documentation](https://doc.dhpc.tudelft.nl/delftblue/). The documentation has a helpful [section](https://doc.dhpc.tudelft.nl/delftblue/howtos/Julia-with-MPI/) dedicated to Julia. The notes below offer additional advice.

#### Self-install

As an alternative to using the software stack, you may want to install Julia from scratch. This makes managing your personalized Julia installation almost as easy as on you own device. 

> [!WARNING]
> If you use this option, you must ensure that OpenBLAS calls only 1 thread (see above). 

This can be done as follows:

1. Follow the instructions in docs for linking scratch spaces to home: https://doc.dhpc.tudelft.nl/delftblue/howtos/Julia-with-MPI/#installing-mpi-package
2. Install `juliaup` as follows: `curl -fsSL https://install.julialang.org | sh`.

Then Julia can be run as follows:

```julia
11:20:40 paltmeyer@login04 ~ → julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.9.3 (2023-08-24)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |
```

> [!TIP]
To avoid running out of memory on your `home/` drive, you may want to move the `juliaup` installation to `scratch`:
```
mkdir -p /scratch/${USER}/.juliaup
ln -s /scratch/${USER}/.juliaup $HOME/.juliaup
```



### Julia on DAIC
