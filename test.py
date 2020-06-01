import add
import time
import numpy as np

n = 10000

a = np.ones((n, ), dtype=np.float32)
b = np.ones((n, ), dtype=np.float32)

print('************************************')
start = time.time()
c_py = add.py_add(a, b)
python_time = time.time() - start
print('Naive python took', python_time, 'seconds')

start = time.time()
c_cy = add.cython_add(a, b)
cython_time = time.time() - start
print('Cython took', cython_time, 'seconds')

start = time.time()
c_c = add.c_wrapped_add(a, b)
c_wrapped_time = time.time() - start
print('C wrapped took', c_wrapped_time, 'seconds')

print('************************************')

print('Cython is ', python_time / cython_time, 'times faster')
print('C wrapped', python_time / c_wrapped_time, 'times faster')

assert(np.linalg.norm(c_py - c_cy) < 1e-10)
assert(np.linalg.norm(c_py - c_c) < 1e-10)
