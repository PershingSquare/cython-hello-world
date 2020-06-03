#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

void add_vectors_mpi(   float *a,
                        float *b,
                        float *c,
                        int dim)
{
    int comm_sz;
    int my_rank;
    MPI_Comm_size (MPI_COMM_WORLD, &comm_sz);
    MPI_Comm_rank (MPI_COMM_WORLD, &my_rank);
    
    int local_dim = dim / comm_sz;

    float *local_a = malloc(local_dim * sizeof(float));
    float *local_b = malloc(local_dim * sizeof(float));
    float *local_c = malloc(local_dim * sizeof(float));

    MPI_Scatter(a, local_dim, MPI_FLOAT, local_a, local_dim, MPI_FLOAT, 0, MPI_COMM_WORLD);
    MPI_Scatter(b, local_dim, MPI_FLOAT, local_b, local_dim, MPI_FLOAT, 0, MPI_COMM_WORLD);


    for (int local_i = 0; local_i < local_dim; local_i++)
    {
        local_c[local_i] = local_a[local_i] + local_b[local_i];
    }

    MPI_Gather(local_c, local_dim, MPI_FLOAT, c, local_dim, MPI_FLOAT, 0, MPI_COMM_WORLD);

    free(local_a);
    free(local_b);
    free(local_c);
}
