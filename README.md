# Julia on HPC for dummies

Small repo that contains a number of Julia example scripts that can be used for running Julia on an HPC.

## Things I've noted

### Julia on DelftBlue

Below I document some of the more disruptive issues I've encountered when trying to work with Julia on DelftBlue along with advice for troubleshooting.
#### Package manager is slow

For some reason, the package manager is incredibly slow on DelftBlue. Simple standard commands like `resolve`, `update`, `instantiate` can take a long time. 

#### Julia versions are specific

Only very specific Julia versions are available on DelftBlue, each tied to one of the different software stacks. For example, at the time of writing, the following versions are available

```
09:07:51 paltmeyer@login04 ~ → module spider julia

----------------------------------------------------------------------------------------
  julia:
----------------------------------------------------------------------------------------
     Versions:
        julia/1.6.3-intel-mkl
        julia/1.8.2
     Other possible modules matches:
        libuv-julia

----------------------------------------------------------------------------------------
  To find other possible module matches execute:

      $ module -r spider '.*julia.*'

----------------------------------------------------------------------------------------
  For detailed information about a specific "julia" package (including how to load the modules) use the module's full name.
  Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider julia/1.8.2
----------------------------------------------------------------------------------------
```

Version `v1.6.3` is tied to the `2022r2` stack:

```
09:07:55 paltmeyer@login04 ~ → module spider julia/1.6.3

----------------------------------------------------------------------------------------
  julia: julia/1.6.3-intel-mkl
----------------------------------------------------------------------------------------

    You will need to load all module(s) on any one of the lines below before the "julia/1.6.3-intel-mkl" module is available to load.

      2022r2
 
    Help:
      The Julia Language: A fresh approach to technical computing
```

This can lead to unexpected behaviour because packages are typically tested on the latest available (minor) version of Julia. For example, the `Zygote` auto-differentiation library is currently being [tested](https://github.com/FluxML/Zygote.jl/actions/runs/5892341473/job/15981385523#step:3:10) on Julia `v1.6.7`. It is not, as far as I can tell, being tested explicitly on `v1.6.3`. 

##### Advice

Test things locally first, making sure that you are using the *exact* same Julia version as on DelftBlue. The easiest way to do this is using [`juliaup`](https://github.com/JuliaLang/juliaup) on your own device. Turning back to the `Zygote` example, let's see if this package is compatible with Julia `v1.6.3`. To do so, install and execute the corresponding Julia version as follows:

```
juliaup add 1.6.3
julia +1.6.3
julia> versioninfo()
Julia Version 1.6.3
Commit ae8452a9e0 (2021-09-23 17:34 UTC)
Platform Info:
  OS: macOS (x86_64-apple-darwin19.5.0)
  CPU: Intel(R) Core(TM) i9-9880H CPU @ 2.30GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-11.0.1 (ORCJIT, skylake)
Environment:
  JULIA_EDITOR = code
```

Then enter `Pkg` mode by hitting the `]` key and activate a local environment as follows:

```julia
(myenv) pkg> activate myenv
  Activating new environment at `~/myenv/Project.toml`
```

The environment is currently empty,

```julia
(myenv) pkg> st
      Status `~/myenv/Project.toml` (empty project)
```

so let's add the `Zygote` package:

```julia
(myenv) pkg> add Zygote
   Resolving package versions...
    Updating `~/myenv/Project.toml`
  [e88e6eb3] + Zygote v0.6.63
    Updating `~/myenv/Manifest.toml`
  [621f4979] + AbstractFFTs v1.5.0
  [79e6a3ab] + Adapt v3.6.2
  [fa961155] + CEnum v0.4.2
  [082447d4] + ChainRules v1.53.0
  [d360d2e6] + ChainRulesCore v1.16.0
  [9e997f8a] + ChangesOfVariables v0.1.8
  [bbf7d656] + CommonSubexpressions v0.3.0
  [34da2185] + Compat v4.9.0
  [9a962f9c] + DataAPI v1.15.0
  [e2d170a0] + DataValueInterfaces v1.0.0
  [163ba53b] + DiffResults v1.1.0
  [b552c78f] + DiffRules v1.15.1
  [ffbed154] + DocStringExtensions v0.9.3
  [1a297f60] + FillArrays v1.5.0
  [f6369f11] + ForwardDiff v0.10.36
  [0c68f7d7] + GPUArrays v8.8.1
  [46192b85] + GPUArraysCore v0.1.5
  [7869d1d1] + IRTools v0.4.10
  [3587e190] + InverseFunctions v0.1.12
  [92d709cd] + IrrationalConstants v0.2.2
  [82899510] + IteratorInterfaceExtensions v1.0.0
  [692b3bcd] + JLLWrappers v1.5.0
  [929cbde3] + LLVM v6.1.0
  [2ab3a3ac] + LogExpFunctions v0.3.24
  [1914dd2f] + MacroTools v0.5.10
  [77ba4419] + NaNMath v1.0.2
  [bac558e1] + OrderedCollections v1.6.2
  [aea7be01] + PrecompileTools v1.1.2
  [21216c6a] + Preferences v1.4.0
  [c1ae055f] + RealDot v0.1.0
  [189a3867] + Reexport v1.2.2
  [ae029012] + Requires v1.3.0
  [276daf66] + SpecialFunctions v2.3.1
  [90137ffa] + StaticArrays v1.6.2
  [1e83bf80] + StaticArraysCore v1.4.2
  [09ab397b] + StructArrays v0.6.15
  [3783bdb8] + TableTraits v1.0.1
  [bd369af6] + Tables v1.10.1
  [e88e6eb3] + Zygote v0.6.63
  [700de1a5] + ZygoteRules v0.2.3
  [dad2f222] + LLVMExtra_jll v0.0.23+0
  [efe28fd5] + OpenSpecFun_jll v0.5.5+0
  [0dad84c5] + ArgTools
  [56f22d72] + Artifacts
  [2a0f44e3] + Base64
  [ade2ca70] + Dates
  [8ba89e20] + Distributed
  [f43a241f] + Downloads
  [b77e0a4c] + InteractiveUtils
  [4af54fe1] + LazyArtifacts
  [b27032c2] + LibCURL
  [76f85450] + LibGit2
  [8f399da3] + Libdl
  [37e2e46d] + LinearAlgebra
  [56ddb016] + Logging
  [d6f4376e] + Markdown
  [ca575930] + NetworkOptions
  [44cfe95a] + Pkg
  [de0858da] + Printf
  [3fa0cd96] + REPL
  [9a3f8284] + Random
  [ea8e919c] + SHA
  [9e88b42a] + Serialization
  [6462fe0b] + Sockets
  [2f01184e] + SparseArrays
  [10745b16] + Statistics
  [fa267f1f] + TOML
  [a4e569a6] + Tar
  [8dfed614] + Test
  [cf7118a7] + UUIDs
  [4ec0a83e] + Unicode
  [e66e0078] + CompilerSupportLibraries_jll
  [deac9b47] + LibCURL_jll
  [29816b5a] + LibSSH2_jll
  [c8ffd9c3] + MbedTLS_jll
  [14a3606d] + MozillaCACerts_jll
  [05823500] + OpenLibm_jll
  [83775a58] + Zlib_jll
  [8e850ede] + nghttp2_jll
  [3f19e933] + p7zip_jll
Precompiling project...
  ✗ Zygote
  3 dependencies successfully precompiled in 40 seconds (43 already precompiled)
  1 dependency errored. To see a full report either run `import Pkg; Pkg.precompile()` or load the package
```

Unfortunately, the package does not precompile, so we neither use `Zygote` nor any packages that depend on it (which currently include the majority of Julia's deep learning stack).





