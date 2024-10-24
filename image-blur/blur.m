clear

%% Number of processors
% Set this equal to the number of CPUs you allocated divided by 2
nProcs = 8;
if nProcs > 1
    if isempty(gcp('nocreate'))
        parpool(nProcs);
    end
end

%% Load the input file
imageDir = "images";
imageFilename = "building";

originalImg = rgb2gray(imread(imageDir + filesep + imageFilename + ".jpg"));

%% Define the convolution kernel
% For this, we will use a simple "box blur". You can use more
% sophisticated kernels, such as a Gaussian blur.
kernelSize = 45;
kernel = (1/kernelSize^2) * ones(kernelSize);

%% Partition the image into non-overlapping segments
% We will partition the image into the same number of chunks as we have
% processors in the parallel pool.
blocks = partitionImage(originalImg, nProcs);

blurredBlocks = cell(size(blocks));

%% Do the convolution
tic

if nProcs > 1
    parfor blockNum = 1:nProcs
       blurredBlocks{blockNum} = conv2(blocks{blockNum}, kernel, "same");
    end
else
    for blockNum = 1:nProcs
       blurredBlocks{blockNum} = conv2(blocks{blockNum}, kernel, "same");
    end
end

elapsedTime = toc;
disp("elapsed time = " + num2str(elapsedTime))

%% Recombine the blocks
blurredImg = recombineImage(blurredBlocks);

% Normalize back to uint8
normalizationFactor = 255 / max(blurredImg, [], "all");
blurredImg = uint8(blurredImg * normalizationFactor);

% Save the image
imwrite(blurredImg, imageDir + filesep + imageFilename + "-blurred.jpg")
