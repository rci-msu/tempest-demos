# MPI examples in Julia

MPI is a software for running multinode jobs as an alternative to multithreading for parallel processing.

These code examples show general ways to send data between nodes using two different methods that can be adapted for 
your own code. 

## MPI broadcast

`broadcastMPI.jl` shows a minimal working example of broadcasting data to all workers except itself.

## MPI send and receive

`sendRecvMPI.jl` shows a minimal working example of sending and receiving data between specific workers.

## Running the code

### Setup Julia environment

Before running the examples, you must setup a Julia environment with the required libraries.

```bash
module load OpenMPI/
module load Julia/

# Create the Julia environment
julia -e env/createEnv.jl
```

### Launch the sbatch script

Both examples are run with the `run_mpiExamples.sbatch` script:

```bash
sbatch run_mpiExamples.sbatch
```
