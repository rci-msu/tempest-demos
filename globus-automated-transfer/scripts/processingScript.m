function processedImage = processingScript(imageTag)
    image = imread(['../important-data/loretta',num2str(imageTag),'.jpg']);
    processedImage = im2gray(image);
    save(['../results/processedLoretta',num2str(imageTag),'.jpg'],'processedImage');
end 