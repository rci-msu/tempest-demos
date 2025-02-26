using Pkg
Pkg.activate("mpiEnv")
Pkg.add("BenchmarkTools")
Pkg.add("MPI")
Pkg.add("MPIPreferences")
Pkg.precompile()
Pkg.instantiate()
