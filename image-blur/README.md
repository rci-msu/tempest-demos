# Paralell image blurring
This example blurs an image using 2D convolution. Image processing algorithms are often easy to parallelize.

## Running the example
1. Edit `blur.m` to load the image you want to use from the `images` directory
2. Set the `nProcs` to the number of CPUs you allocated divided by 2
3. run `blur.m`, either in an interactive desktop or in an sbatch script

## Exercises
1. See how the computation time changes with number of processors. Is the parallel version faster than the serial version? If not, why?
2. Try changing the kernel size; see how the blurring changes.
3. Try using a different convolution kernel, such as a Gaussian kernel or an edge detection kernel: [https://en.wikipedia.org/wiki/Kernel_(image_processing](https://en.wikipedia.org/wiki/Kernel_(image_processing))
