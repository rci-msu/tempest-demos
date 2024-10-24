function blocks = partitionImage(img, nPartitions)

    [nRows, nCols] = size(img);

    if nRows >= nCols
        blocks = mat2cell(img, ...
            [repmat(ceil(nRows/nPartitions), [1 mod(nRows, nPartitions)]), ...
            repmat(floor(nRows/nPartitions), [1 nPartitions - mod(nRows, nPartitions)])], nCols);
    else
        blocks = mat2cell(img, nRows, ...
            [repmat(ceil(nCols/nPartitions), [1 mod(nCols, nPartitions)]), ...
            repmat(floor(nCols/nPartitions), [1 nPartitions - mod(nCols, nPartitions)])]);
    end

end

