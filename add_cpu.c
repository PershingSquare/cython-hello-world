#include <stdlib.h>

void add_array(float *a, float *b, float *c, int dim)
{
    for (int i = 0; i < dim; i++)
    {
        c[i] = a[i] + b[i];
    }
}
