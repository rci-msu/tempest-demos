This example uses dependencies and the Globus CLI tool in order to automate transfers from Blackmore to Tempest, process data, and then clean up loose data while retaining the results. This is a useful replacement for manually moving around data using Globus and then running scripts on Tempest to process the data.


Folders:
globus-automated-transfer -> Top level folder

|-- batch -> Contains the Slurm scripts for the example. 

|-- results -> Contains results from the computations

|-- scripts -> Contains the scripts used for processing the data

|-- transfer-data -> Folder that data is moved into from Blackmore. Everything in this folder is removed during the cleanup job at the end of the dependency.


