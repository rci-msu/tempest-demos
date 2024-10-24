# Handwritten digit classificaiton using convolutional neural networks
The purpose of this example is to see how much faster using a GPU can be for certain workloads, especially machine learning.

This example trains a convolutional neural network to classify handwritten digits (0--9) using the [MNIST dataset](https://en.wikipedia.org/wiki/MNIST_database). It is adapted from an [official Mathworks Example](https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html).

## Running the example
There are two ways to run the example:
1. Using the MATLAB GUI in a remote desktop session.
2. Submitting an sbatch job.

Before running the example, `data.zip` needs to be unzipped:
```
unzip data.zip
```

### Using the MATLAB GUI
1. Launch a Tempest Xfce Desktop interactive session
2. In the remote desktop session, open a terminal and load the following modules:
    - `module load math/matlab`
    - `module load cuDNN/8.7.0.84-CUDA-11.8.0`
3. In the terminal, launch MATLAB: `matlab`
4. In MATLAB, navigate to the folder containing this README, open up the `mnistClassification.m` file and run it.

### Using sbatch
There are two options here:
1. Use the Job Composer in Tempest Web
2. Use the terminal

#### Job composer
Copy the contents of the `.sbatch` file in this folder into the job composer and submit the job.

#### Terminal
Navigate to this folder and run `sbatch run-mnist-classification.sbatch`

## Exercises
1. Time how long the neural network training takes using `tic` and `toc`. Print out the elapsed time.
2. Compare training times using:
    - a CPU
    - an A40 GPU
    - an A100 GPU
    - an H100 GPU
    - mutliple A40, A100, or H100 GPUs

