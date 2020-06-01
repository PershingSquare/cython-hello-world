import numpy as np
cimport numpy as np
cimport cython
from cython cimport view
from cython.parallel import prange

DTYPE = np.float32
ctypedef np.float32_t DTYPE_t

# Python Example

def py_add(a, b):
    # Using a + b calls a c library
    return [x + y for x, y in zip(a, b)]

# Cython Example
@cython.boundscheck(False)
@cython.wraparound(False)
def cython_add(const np.float32_t[::1] a, const np.float32_t[::1] b):

    cdef int N = a.shape[0]
    cdef np.float32_t[::1] c = np.empty(N, dtype=DTYPE)
    cdef int i
    with nogil:
        for i in range(N):
            c[i] = a[i] + b[i]

    return c.base

# Cython prange Example
@cython.boundscheck(False)
@cython.wraparound(False)
def cython_padd(const np.float32_t[::1] a, const np.float32_t[::1] b):
    cdef int N = a.shape[0]
    cdef int i
    cdef np.float32_t[::1] c = np.empty(N, dtype=DTYPE)
    for i in prange(N, nogil=True, schedule='guided'):
        c[i] = a[i] + b[i]

# Cython wrapped C

cdef extern from "add_cpu.c":
    pass

cdef extern from "add_cpu.h":
    void add_array(float *, float *, float *, int)

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

    add_array(<float*> a.data, <float*> b.data, <float*> c.data, items)

    return c
'''
cdef extern from "add_gpu.cu":
    pass

cdef extern from "add_gpu.cuh":
    void vecAddGPU(float *, float *, float *, int)

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

    vecAddGPU(<float*> a.data, <float*> b.data, <float*> c.data, items)

    return c

# TODO:
# Cython wrapped C++
# Cython wrapped C std::vector
# Cython wrapped C struct
# Cython wrapped C MPI
'''
