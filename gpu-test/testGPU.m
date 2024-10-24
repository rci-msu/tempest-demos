%% See how much faster a GPU is at doing a big matrix multiplication
function [gpuSpeedup,mmGFlopsGPU] = testGPU(mSize)

gpu = gpuDevice();
fprintf('Using an %s GPU.\n', gpu.Name)

sizes = power(2, mSize);
N = sqrt(sizes);

%% First do it on the host
A = rand( N, N );
B = rand( N, N );
cputime = timeit(@() A*B);

%% Now on the GPU
A = gpuArray(A);
B = gpuArray(B);
gputime = gputimeit(@() A*B);

gpuSpeedup = cputime / gputime;

mmGFlopsGPU = (2*N.^3 - N.^2)./theTime/1e9;
fprintf(['Achieved peak calculation rates of ', ...
    '%1.1f GFLOPS\n'], mmGFlopsGPU)