#!/bin/bash

## Specify the account to use; you must use your priority account.
#SBATCH --account=priority-joeshaw

## Use the priority partition.
#SBATCH --partition=priority

## Number of CPUs to allocate. Note that in the slurm, CPUs correspond to
## logical processors, not physical cores.
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G

## Maximum job run time. Format is days-HH:MM:SS.
#SBATCH --time=0-01:00:00

## Set job name.
#SBATCH --job-name=cleanupData

## Set output log and error log filenames. 
## %j is the job number and %x is the job name set above 
#SBATCH --output=%x.out
#SBATCH --error=%x.err

## Run 'man sbatch' for more information on the options above.
## Below, enter commands needed to execute your workload

rm /home/group/joeshaw/matlab-globus-example/important-data/*

