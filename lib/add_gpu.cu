#include "add_gpu.cuh"

__global__ void vecAdd(float *a, float *b, float *c, int n)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if (idx < n)
    {
        c[idx] = a[idx] + b[idx];
    }
}

void add_gpu(float *a, float *b, float *c, int n)
{
    float *d_a;
    float *d_b;
    float *d_c;

    cudaMalloc(&d_a, n * sizeof(float));
    cudaMalloc(&d_b, n * sizeof(float));
    cudaMalloc(&d_c, n * sizeof(float));

    cudaMemcpy(d_a, a, n * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, n * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_c, c, n * sizeof(float), cudaMemcpyHostToDevice);
    
    int blockSize = 1024;
    int gridSize = (int) ceil((float) n / blockSize);

    vecAdd<<<gridSize, blockSize>>>(d_a, d_b, d_c, n);

    cudaMemcpy(a, d_a, n * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(b, d_b, n * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(c, d_c, n * sizeof(float), cudaMemcpyDeviceToHost);
    
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
}
