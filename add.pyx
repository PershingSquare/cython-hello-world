import numpy as np
cimport numpy as np
cimport cython
from cython cimport view

DTYPE = np.float32
ctypedef np.float32_t DTYPE_t

# Python Example
def py_add(a, b):
    """
        Computes a + b using the Python interpreter.
        Note that I avoid doing a + b because that calls
        a C library.
    """
    return [x + y for x, y in zip(a, b)]

# Cython Example
@cython.boundscheck(False)
@cython.wraparound(False)
def cython_add(const np.float32_t[::1] a, const np.float32_t[::1] b):
    """
        Computes a + b using Cython.
    """

    cdef int N = a.shape[0]
    cdef np.float32_t[::1] c = np.empty(N, dtype=DTYPE)
    cdef int i
    with nogil:
        for i in range(N):
            c[i] = a[i] + b[i]

    return c.base

# Cython wrapped C
cdef extern from "add_cpu.h":
    void add_cpu(float *a, float *b, float *c, int items)

def c_wrapped_add(
        np.ndarray[DTYPE_t, ndim=1] a,
        np.ndarray[DTYPE_t, ndim=1] b):

    cdef int items = a.shape[0]

    cdef np.ndarray c = np.empty((items, ), dtype=DTYPE)

    if not a.flags['C_CONTIGUOUS']:
        a = np.ascontiguousarray(a)

    if not b.flags['C_CONTIGUOUS']:
        b = np.ascontiguousarray(b)

    if not c.flags['C_CONTIGUOUS']:
        c = np.ascontiguousarray(c)

    add_cpu(<float*> a.data, <float*> b.data, <float*> c.data, items)

    return c

cdef extern from "add_gpu.cuh":
    void add_gpu(float *a, float *b, float *c, int items)

def gpu_wrapped_add(
        np.ndarray[DTYPE_t, ndim=1] a,
        np.ndarray[DTYPE_t, ndim=1] b):

    cdef int items = a.shape[0]

    cdef np.ndarray c = np.zeros((items, ), dtype=DTYPE)

    if not a.flags['C_CONTIGUOUS']:
        a = np.ascontiguousarray(a)

    if not b.flags['C_CONTIGUOUS']:
        b = np.ascontiguousarray(b)

    if not c.flags['C_CONTIGUOUS']:
        c = np.ascontiguousarray(c)

    add_gpu(<float*> a.data, <float*> b.data, <float*> c.data, items)

    return c
