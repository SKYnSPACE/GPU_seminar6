#include <stdio.h>
#include <sys/time.h>

#define N (65535)
#define HANDLE_ERROR( err ) (HandleError( err, __FILE__, __LINE__))

static void HandleError( cudaError_t err, const char *file, int line)
{
	if (err != cudaSuccess)
	{
		printf("%s in %s at line %d\n", cudaGetErrorString (err ), file, line);
		exit( EXIT_FAILURE );
	}
}

double get_time()
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (double)tv.tv_sec + (double)1e-6 * tv.tv_usec;
}

__global__ void add (int *a, int *b, int *c)
{
	/* PLEASE COMPLETE THE CODE */
}

void add_cpu (int *a, int *b, int *c)
{
	/* PLEASE COMPLETE THE CODE */
}

int main(void)
{
	int a[N], b[N], c[N];
	int *dev_a, *dev_b, *dev_c;
	double start_time, end_time;

	//INITIALIZE THE ARRAY
	for (int i=0; i<N; i++)
	{
		a[i] = i;
		b[i] = i*i;
	}

	//GPU MEMORY ALLOCATION for dev_a, dev_b, and dev_c.
	/* PLEASE COMPLETE THE CODE */

	//COPY a and b to ALLOCATED GPU MEMORY
	/* PLEASE COMPLETE THE CODE */

	//GPU CALCULATION TAKES PLACE
	start_time = get_time();
	/* PLEASE COMPLETE THE CODE */
	end_time = get_time();
	printf("[GPU]: %f sec Elpased\n", end_time - start_time);
	
	//COPY c to HOST
	/* PLEASE COMPLETE THE CODE */
	
	//CHECK FOR THE INTEGRITY
	bool success = true;
	for (int i=0; i<N; i++)
	{
		if ((a[i] + b[i])!=c[i])
		{
			printf("%d + %d != %d\n", a[i], b[i], c[i]);
			success = false;
		}
	}

	if (success)
	{
		printf("GPU TEST SUCCESSFUL!\n");
	}

	//FREE the CUDA MEMORY
	/* PLEASE COMPLETE THE CODE */
	
	//CPU CALCULATION TAKES PLACE
	start_time = get_time();
	add_cpu(a, b, c);
	end_time = get_time();
	printf("[CPU]: %f sec Elpased\n", end_time - start_time);

	//CHECK FOR THE INTEGRITY
	for (int i=0; i<N; i++)
	{
		if ((a[i] + b[i])!=c[i])
		{
			printf("%d + %d != %d\n", a[i], b[i], c[i]);
			success = false;
		}
	}

	if (success)
	{
		printf("CPU TEST SUCCESSFUL!\n");
	}
	
}
