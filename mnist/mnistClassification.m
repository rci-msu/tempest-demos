%% Classification of handwritten digits using a deep nerual network
% This example trains a neural network to classify handwritten digits
% from the MNIST dataset (https://en.wikipedia.org/wiki/MNIST_database)
%
% We use the Deep Learning Toolbox to create a neural network.
%
% This example is adapted from an official Mathwork's example:
% https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html
clear all;

%% Load in the MNIST dataset
% NOTE: if you are not running the code from the mnist directory where
% this script is located, you need to change the dataFolder path.
dataFolder = "data";

% Use a datastore to load the images. This way we don't need to store
% all the images in RAM (even though they could certainly fit).
% The subfolders are named with the digit (e.g., 0, 4, 8, etc.), so
% we can use the folder names as the labels for the images.
datastore = imageDatastore(dataFolder, IncludeSubfolders=true, ...
    LabelSource="foldernames");

classNames = categories(datastore.Labels);
nClasses = numel(unique(classNames));

% Grab the image size. The size of the input layer needs to be the same
% as the number of pixels in each image.
imgSize = size(readimage(datastore,1));

%% Split the data into training and testing sets
% Use 80% of the data for training and 20% for testing. The data is
% randomly split into training and testing sets; the proportion of each
% class will be about equal in the training and testing sets.
trainingPct = 0.8;

[trainingDatastore, testingDatastore] = splitEachLabel(datastore,...
    trainingPct, "randomized");

%% Define the convolutional neural network architecture
% This network architecture is copied from the Mathworks example.
% Feel free to play around with the layer sizes and number of layers.
layers = [
    imageInputLayer([imgSize, 1])

    convolution2dLayer(3, 8, Padding="same")
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, Stride=2)

    convolution2dLayer(3, 16, Padding="same")
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, Stride=2)

    convolution2dLayer(3, 32, Padding="same")
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(nClasses)
    softmaxLayer
    classificationLayer
];

%% Train the neural network

% To train with mutliple GPUs, set the ExecutionEnvironment to "multi-gpu"
% To train with CPUs, set the ExecutionEnvironment to "cpu"
options = trainingOptions("sgdm", ...
    InitialLearnRate=0.01, ...
    MaxEpochs=30, ...
    Shuffle="every-epoch", ...
    Plots="none", ...
    Verbose=true, ...
    ExecutionEnvironment="gpu");

network = trainNetwork(trainingDatastore, layers, options);

%% Classify images in the testing set
% We use the testing set to see how accurate the neural network is at
% classifying images it hasn't seen before.

predictedLabels = classify(network, testingDatastore);

trueLabels = testingDatastore.Labels;

accuracy = mean(predictedLabels == trueLabels);
disp("accuracy = " + num2str(accuracy))