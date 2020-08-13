# Cython-Hello-World

Contains multiple examples of adding two vectors.

At a high level, the steps for getting a C program/CUDA/MPI program look like this.

1. Write all your code in C++/C.

2. Compile and create a static library.

3. Create a `.pxy' Cython wrapper to go from C++/C into Cython.

4. Using setuptools and Cython, create a Python module.

5. Import the module that you created into Python!
