# Monte Carlo Pi MATLAB implementation

## Running the code

`runFullNode.slurm` launches `compare.m`, which compares the speed of calculating Pi in parallel (`calculatePiPar.m`) and sequentially (`calculatePi.m`).

Run the job with
```bash
sbatch runFullNode.slurm
```
