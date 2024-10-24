#!/bin/bash
#SBATCH --partition priority
#SBATCH --account priority-csci494
#SBATCH --ntasks 128
#SBATCH --nodes 4
#SBATCH --cpus-per-task 1
#SBATCH --mem-per-cpu 1000
#SBATCH --time 0-01:00:00
#SBATCH --job-name mpi-pi
#SBATCH --output %x-%j.out
#SBATCH --error %x-%j.err
#SBATCH --mail-type ALL
start=`date +%s`
module load Anaconda3/2022.05
module load OpenMPI/4.1.4-GCC-11.3.0 
MACHINEFILE="nodes.$SLURM_JOBID"
source activate pythonmpi
mpirun -n 128 python calculate_pi_mpi.py -machinefile $MACHINEFILE
end=`date +%s`
runtime=$((end-start))
printf "time elapsed %d seconds\n" "$runtime"
