#!/bin/bash

## Specify the account to use; you must use your priority account.
#SBATCH --account=priority-<account-name>

## Use the priority partition.
#SBATCH --partition=priority

## Number of CPUs to allocate. Note that in the slurm, CPUs correspond to
## logical processors, not physical cores.
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G

## Maximum job run time. Format is days-HH:MM:SS.
#SBATCH --time=0-01:00:00

## Set job name.
#SBATCH --job-name=transferData

## Set output log and error log filenames. 
## %j is the job number and %x is the job name set above 
#SBATCH --output=%x.out
#SBATCH --error=%x.err

## Run 'man sbatch' for more information on the options above.
## Below, enter commands needed to execute your workload

# Load Matlab and Globus CLI tool and verify that you are logged in
module load Globus-CLI
globus login
globus whoami

# Set environmental variables for $blackmore and $tempest, along with personal endpoint if wanted.
BLACKMORE=5485832e-723e-4b52-8472-0410e90902ad
TEMPEST=0dc1297f-9868-4c68-8637-c9b6bd65d3aa
# personal=<UUID-HERE>


# Transfer Entire Folder
#   - The --recursive flag for the globus transfer is used to transfer an entire folder selected as the source.
SOURCE_PATH="~/source/folder/here/"
DESTINATION_PATH="/destination/folder/here/"

recursive_id="$(globus transfer $BLACKMORE:$SOURCE_PATH $TEMPEST:$DESTINATION_PATH --recursive --jmespath 'recursive_id' --format=UNIX)"
globus task wait "$recursive_id" --timeout 180
if [ $? -eq 0 ]; then
    echo "$recursive_id completed successfully";
else
    echo "$recursive_id failed!";
fi


# Transfer Selected Files
#   - Uses the batch flag to pass a file containing the sources and destinations of the files and folders 
#   - BATCH FILE FORMAT:
#       /source/file/here1.txt ~/destination/here
#       /source/file/here2.txt ~/destination/here
batch_id="$(globus transfer $BLACKMORE $TEMPEST --batch batchFileHere.txt --jmespath 'batch_id' --format=UNIX)"
globus task wait "$batch_id" --timeout 180
if [ $? -eq 0 ]; then
    echo "$batch_id completed successfully";
else
    echo "$batch_id failed!";
fi


# Transfer Single File
#   - Transfer a single file to a destination 
SOURCE_PATH="~/source/file/here/"
DESTINATION_PATH="/destination/file/here/"

single_id="$(globus transfer $BLACKMORE:$SOURCE_PATH $TEMPEST:$DESTINATION_PATH --jmespath 'single_id' --format=UNIX)"
globus task wait "$single_id" --timeout 180
if [ $? -eq 0 ]; then
    echo "$single_id completed successfully";
else
    echo "$single_id failed!";
fi
