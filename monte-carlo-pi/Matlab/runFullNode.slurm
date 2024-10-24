#!/bin/bash
##
## gpuexample.sbatch submit a job using a GPU
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=group-rci 		        # priority account to use
#SBATCH --reservation=reushow		        # user reservation
#SBATCH --job-name=montePi              # job name
#SBATCH --partition=unsafe                # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=256		          # number of cores to allocate - do not allocate more than 16 cores per GPU
#SBATCH --mem=1000G                     # 2000 MB of Memory allocated - do not allocate more than 128000 MB mem per GPU
#SBATCH --time=0-00:30:00               # Maximum job run time
#SBATCH --output=%x-%j.out            	# standard output file (%A = jobid, %a = arrayid)
#SBATCH --error=%x-%j.err             	# standard error file
echo "Hello from $(hostname)."
module load math/matlab/2023a

matlab -batch compare
