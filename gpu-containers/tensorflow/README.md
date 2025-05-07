# gpuContainers101 using Apptainer


## Get the Container
Run the below to pull the optimzed GPU conatiner from Nvidia  

`apptainer pull tfGpu.sif docker://nvcr.io/nvidia/tensorflow:22.07-tf2-py3`  

Here is an explantion of the input parmeters
 - `pull` retreive a conatiner from the internet
 - `tfGpu.sif` the file you want to save the conatiner into
   - You can rename the .sif to be whatever you want just remember to use it in the next step. 
 - `docker://nvcr.io/nvidia/tensorflow:22.07-tf2-py3` The container we are pulling 
   - Notice that the `docker://` this tells singularty we want to pull from the docker registry.  

## Test the Container
Before running a full program, Container can be tested by just running a small python script, 
This script just shows that Tensorflow is imported into the program and uses GPU device.

`apptainer exec --nv -B $PWD:/code tfGpu.sif python test-tf-container-with-gpu.py`

## Run the Container
Run to execute to mnist code on the GPU  

`apptainer exec --nv -B $PWD:/code tfGpu.sif /code/run_in_container.sh`  

Here is an explantion of the input parmeters
 - `exec` execute code using a continer
 - `--nv` use the nvidia gpu
 - `-B` make a bind so the container can see files
 - `$PWD` output the current working directory
 - `$PWD:/code` this mounts the current directoy to /code in the container
 - `tfGpu.sif` the container we are using to execute to code
 - `/code/run_in_container.sh` the file to run in the container


## Notes
Here is the Container Platform we are using
[Apptainer](https://apptainer.org/docs/user/1.3/)

The MNIST code is largely based on 
[MNIST](https://machinelearningmastery.com/how-to-develop-a-convolutional-neural-network-from-scratch-for-mnist-handwritten-digit-classification/)

Here is the Nvidia NGC container regisrty for optimazed GPU containers
[Nvidia NGC](https://catalog.ngc.nvidia.com/)

Here is the offical Tensorflow container
[TF container](https://hub.docker.com/r/tensorflow/tensorflow)

Here is the RCI's internal guide to use Yolo Container 
[Yolo Container](https://msudocs.atlassian.net/wiki/x/JoCqTw)

