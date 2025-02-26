#!/bin/bash
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-rci           # specify the account to use
#SBATCH --partition=priority             # queue partition to run the job in
#SBATCH --job-name=mpiExamples
#SBATCH --nodes=5                        # number of nodes to allocate
#SBATCH --ntasks-per-node=1              # number of MPI tasks per node
#SBATCH --cpus-per-task=4                # number of cores to allocate
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=0-01:00:00                # Maximum job run time
#SBATCH --output=%x.out
#SBATCH --error=%x.err

## Run 'man sbatch' for more information on the options above.

module load OpenMPI/
module load Julia/

ENV_NAME="env/mpiEnv"

mpiexec --mca pml ob1 --mca btl tcp,self julia --project="${ENV_NAME}" broadcastMPI.jl
mpiexec --mca pml ob1 --mca btl tcp,self julia --project="${ENV_NAME}" sendRecvMPI.jl
