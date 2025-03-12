This example uses dependencies and the Globus CLI tool in order to automate transfers from Blackmore to Tempest, process data, and then clean up loose data while retaining the results. This is a useful replacement for manually moving around data using Globus and then running scripts on Tempest to process the data.

Prior to running the transfers, you will need to run the globusSetup.sh script found in batch in order to log in to Globus and authorize it on Tempest. You may also run into an issue on your first transfer where you need to authorize access to the Blackmore or Tempest collection. This link for authorization will show up in the .err file of your job.

Folders:
globus-automated-transfer -> Top level folder

|-- batch -> Contains the Slurm scripts for the example. 

|-- results -> Contains results from the computations

|-- scripts -> Contains the scripts used for processing the data

|-- transfer-data -> Folder that data is moved into from Blackmore. Everything in this folder is removed during the cleanup job at the end of the dependency.


