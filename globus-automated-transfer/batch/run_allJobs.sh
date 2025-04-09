# Submit data transfer job and give ID to transferJob variable. The cut command is for trimming down stdout to just give the job ID.
transferJob=$(sbatch run_transferData.sbatch | cut -d ' ' -f 4)

# Run the data processing script after the data transfer job is completed.
processJob=$(sbatch --dependency=afterok:"$transferJob" run_processData.sbatch | cut -d ' ' -f 4)

# Run the cleanup job after the data processing job is complete.
sbatch --dependency=afterok:"$processJob" run_cleanupData.sbatch

