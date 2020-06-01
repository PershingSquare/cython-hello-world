import numpy
from Cython.Build import cythonize
from distutils.core import setup
from distutils.extension import Extension

add_extension = Extension(
        name="add",
        sources=["add.pyx"],
        libraries=["add"],
        library_dirs=["lib"],
        include_dirs=["lib", numpy.get_include()],
        annotate=True
)

setup(
    name = "add",
    ext_modules = cythonize([add_extension])
)
