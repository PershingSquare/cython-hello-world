#include <stdlib.h>
#include "add_cpu.h"

void add_cpu(float *a, float *b, float *c, int dim)
{
    for (int i = 0; i < dim; i++)
    {
        c[i] = a[i] + b[i];
    }
}
