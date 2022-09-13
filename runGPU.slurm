#!/bin/bash
##
## gpuexample.sbatch submit a job using a GPU
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=group-rci 		# priority account to use
#SBATCH --job-name=mnist           # job name
#SBATCH --partition=gpuunsafe         # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=8		# number of cores to allocate - do not allocate more than 16 cores per GPU
#SBATCH --gpus-per-task=1		# number of GPUs to allocate - all GPUs are currently A40 model
#SBATCH --mem=16G                     # 2000 MB of Memory allocated - do not allocate more than 128000 MB mem per GPU
#SBATCH --time=0-01:00:00               # Maximum job run time
#SBATCH --output=mnistGPU_%A_%3a.out 	# standard output file (%j = jobid)
#SBATCH --error=mnistGPU_%A_%3a.err 	# standard error file
#SBATCH --array=0-9
##SBATCH --exclude=tempest-gpu[004-005]
##SBATCH --mail-user=<email address>	# email address to recieve job updates
##SBATCH --mail-type=ALL			# conditions to recieve emial notifications for job
## Run 'man sbatch' for more information on the options above.
date
echo "Hello from $(hostname)."
time -p singularity exec --nv -B $PWD:/code docker://nvcr.io/nvidia/tensorflow:22.07-tf2-py3 /code/test.sh 
echo "Ended batch processing at `date`."
