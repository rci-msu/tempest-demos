#!/bin/bash

## Specify the account to use; you must use your priority account.
#SBATCH --account=priority-<account-name>

## Use the priority partition.
#SBATCH --partition=priority

## Number of CPUs to allocate. Note that in the slurm, CPUs correspond to
## logical processors, not physical cores.
#SBATCH --cpus-per-task=16

#SBATCH --tmp=700G
#SBATCH --mem=32G

## Maximum job run time. Format is days-HH:MM:SS.
#SBATCH --time=0-01:00:00

## Set job name.
#SBATCH --job-name=processData

## Set output log and error log filenames. 
## %j is the job number and %x is the job name set above 
#SBATCH --output=%x.out
#SBATCH --error=%x.err

## A job array with this argument launches multiple jobs that run the same code below with a unique identifier $SLURM_ARRAY_TASK_ID
#SBATCH --array=1-3

## Run 'man sbatch' for more information on the options above.
## Below, enter commands needed to execute your workload

# Move data into tmp scratch directory
echo $tmp_scratch
cp -r ../scripts/ $tmp_scratch/
cp -r ../important-data/ $tmp_scratch/
mkdir $tmp_scratch/results

# Process Data
module load math/matlab
cd $tmp_scratch/scripts
matlab -batch "processingScript($SLURM_ARRAY_TASK_ID)"

# Move Results to Group Directory
cp -r $tmp_scratch/results /home/group/results/folder/here
