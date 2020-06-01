#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

void add_vectors_mpi(   int comm_sz,
                        int my_rank,
                        float *a,
                        float *b,
                        float *c,
                        int dim)
{
    int local_dim = dim / comm_sz;

    float *local_a = malloc(local_dim * sizeof(float));
    float *local_b = malloc(local_dim * sizeof(float));
    float *local_c = malloc(local_dim * sizeof(float));


    float *temp_a = NULL;
    float *temp_b = NULL;

    if (my_rank ==0)
    {
        temp_a = malloc(dim * sizeof(float));
        temp_b = malloc(dim * sizeof(float));
    }

        MPI_Scatter(temp_a, local_dim, MPI_FLOAT, local_a, local_dim, MPI_FLOAT,0, MPI_COMM_WORLD);
        MPI_Scatter(temp_b, local_dim, MPI_FLOAT, local_b, local_dim, MPI_FLOAT, 0, MPI_COMM_WORLD);


    for (local_i = 0; local_i < local_dim; local_i++)
    {
        local_c[local_i] = local_a[local_i] + local_b[local_i];
    }

}
