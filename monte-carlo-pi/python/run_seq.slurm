#!/bin/bash
#SBATCH --partition priority
#SBATCH --account priority-csci494
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 2G
#SBATCH --time 0-01:00:00
#SBATCH --job-name seq-pi
#SBATCH --output seq-pi-%j.out
#SBATCH --error seq-pi-%j.err
#SBATCH --mail-type ALL
start=`date +%s`
#module load Python/3.10.4-GCCcore-11.3.0
python calculate_pi_par.py
end=`date +%s`
runtime=$((end-start))
printf "NOTICE: we ran 10 times less throws\n"
printf "time elapsed %d seconds\n" "$runtime"
printf "time elapsed if same throws %d \n" "$((runtime*10))"
