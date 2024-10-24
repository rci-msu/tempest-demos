#!/bin/bash
#SBATCH --partition priority
#SBATCH --account priority-csci494
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 2G
#SBATCH --time 0-01:00:00
#SBATCH --job-name numpy-pi
#SBATCH --output numpy-pi-%j.out
#SBATCH --error numpy-pi-%j.err
#SBATCH --mail-type ALL
start=`date +%s`
module load Anaconda3/2022.05
source activate pythonmpi
python calculate_pi_numpy.py 
end=`date +%s`
runtime=$((end-start))
printf "time elapsed %d seconds\n" "$runtime"
