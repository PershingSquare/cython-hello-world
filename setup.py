import numpy
from Cython.Build import cythonize
from Cython.Distutils import build_ext
from distutils.core import setup
from distutils.extension import Extension
from distutils.command.build import build as _build
import subprocess
import os
from os.path import join as pjoin

add_extension = Extension(
        name="add",
        sources=["add.pyx"],
        library_dirs = ["lib"],
        libraries=["add", "cudart"],
        include_dirs=["lib", numpy.get_include()]
)

setup(
    name = "add",
    ext_modules = cythonize([add_extension]),
    install_requires=[
        'scipy',
        'numpy'
    ]
)
