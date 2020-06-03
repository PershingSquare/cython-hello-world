import add
import time
import numpy as np
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

n = 10000
a = np.ones((n, ), dtype=np.float32)
b = np.ones((n, ), dtype=np.float32)

if rank == 0:
    print('************************************')
    start = time.time()
    c_py = add.py_add(a, b)
    python_time = time.time() - start
    print('Naive python took', python_time, 'seconds')

    start = time.time()
    c_mpi = add.c_wrapped_add_mpi(a, b)
    mpi_time = time.time() - start
    print('C Wrapped MPI took', mpi_time, 'seconds')

    print('************************************')

    print('C wrapped', python_time / mpi_time, 'times faster')

    assert(np.linalg.norm(c_py - c_mpi) < 1e-10)
