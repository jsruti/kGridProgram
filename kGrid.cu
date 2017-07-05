/*
* Compile: nvcc kGrid.cu -o kGrid.out
* Run: ./kGrid.out
*/
#include <stdio.h>
__global__
void kGrid(int n, int *k) {
	int l = blockIdx.x * blockDim.x + threadIdx.x;
	if(l < n) {
		for(int* i = 0; i < k; i++) {
			for(int* j = 0; j < k; j++) {
				printf("%i", j)
			}
		printf("\n");
		} 
	}
}

int main(void) {
	int N = 1<<20;
	int *k, *d_k;
	k = (int*)malloc(N*sizeof(int));
	
	cudaMalloc(&d_k, N*sizeof(int));

	for(int i = 0; i < N; i++) {
		k[i] = 5;
	}
	
	cudaMemcpy(d_k, k, N*sizeof(int), cudaMemcpyHostToDevice);
	
	kGrid<<<(N+255)/256, 256>>>(N, d_k);
	
	cudaMemcpy(k, d_k, N*sizeof(int), cudaMemcpyDeviceToHost);

	cudaFree(d_k);
	free(k);

	return 0;
}
