#!/bin/bash
## Specify the account to use; you must use your priority account.
#SBATCH --account=priority-reu

## Use the gpupriority partition.
#SBATCH --partition=gpupriority

## Number of CPUs to allocate. Note that in the slurm, CPUs correspond to
## logical processors, not physical cores.
#SBATCH --cpus-per-task=8

#SBATCH --mem=16G

## Allocate GPUs. Format is gpu:<type of GPU>:<# of GPUs>.
## The GPU type is optional. Available types are a40 and a100.
#SBATCH --gres=gpu:a40:1

## Maximum job run time. Format is days-HH:MM:SS.
#SBATCH --time=0-00:10:00

## Set job name.
#SBATCH --job-name=mnist-gpu

## Set output log and error log filenames. 
## %j is the job number and %x is the job name set above 
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

## Remove one # and fill out the following lines if you want to receive emails.
##SBATCH --mail-user=      # enter your email to recieve email notifications
##SBATCH --mail-type=ALL                 # specify conditions on which to recieve emails

## Run 'man sbatch' for more information on the options above.
## Below, enter commands needed to execute your workload

module load math/matlab
module load cuDNN/8.7.0.84-CUDA-11.8.0

matlab -batch mnistClassification
