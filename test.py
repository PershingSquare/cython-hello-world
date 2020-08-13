import add
import time
import numpy as np

n = 10000

a = np.random.rand(n).astype(np.float32)
b = np.random.rand(n).astype(np.float32)

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

start = time.time()
c_cu = add.gpu_wrapped_add(a, b)
c_cu_time = time.time() - start
print('CUDA wrapped took (This will be slower)', c_cu_time, 'seconds')

print('************************************')

print('Cython is ', python_time / cython_time, 'times faster')
print('C wrapped', python_time / c_wrapped_time, 'times faster')
print('CUDA wrapped', python_time / c_cu_time, 'times faster')

np.testing.assert_allclose(c_py, c_cy)
np.testing.assert_allclose(c_py, c_c)
np.testing.assert_allclose(c_py, c_cu)
