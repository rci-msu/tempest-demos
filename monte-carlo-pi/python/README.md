# Monte Carlo calculation of Pi in python

There are four different implementations of the calculation:
- Sequential (`calculate_pi_seq.py`)
- Using the `multiprocessing` library (`calculate_pi_par.py`)
- Using MPI (`calculate_pi_mpi.py`)
- Using Numpy (`calculate_pi_numpy.py`)

These show different parallelization methods that you can use. You can compare the performance of each method.

## Running the code

### Setup a mamba environment

If you haven't already, set up yet, please see our [documentation on setting up mamba](https://www.montana.edu/uit/rci/tempest/software/creating-mamba-env.html).

Once you have mamba set up, create the environment:

```bash
mamba env create -f pythonmpi.yaml
```

### Launch the job

Each method has a different sbatch script:
- `run_seq.slurm`
- `run_par.slurm`
- `run_mpi.slurm`
- `run_numpy.slurm`

Launch the job you want using `sbatch`. For example:
```bash
sbatch run_mpi.slurm
```