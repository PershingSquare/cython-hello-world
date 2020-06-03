import numpy
from Cython.Build import cythonize
from distutils.core import setup
from distutils.extension import Extension
from distutils.command.build import build as _build
import subprocess
import os

mpi_compile_args = os.popen("mpicc --showme:compile").read().strip().split(' ')
mpi_link_args = os.popen("mpicc --showme:link").read().strip().split(' ')

def make_all():
    if subprocess.call(["make"]):
            raise EnvironmentError("Makefile failed!")
make_all()

add_extension = Extension(
        name="add",
        sources=["add.pyx"],
        libraries=["add"],
        library_dirs=["lib"],
        include_dirs=["lib", numpy.get_include()],
        extra_compile_args=mpi_compile_args,
        extra_link_args=mpi_link_args,
        annotate=True
)

class RunMakefile(_build):
    def run(self):
        make_all()
        _build.run(self)

setup(
    name = "add",
    ext_modules = cythonize([add_extension]),
    cmdclass={
        'build' : RunMakefile,
        },
    install_requires=[
        'scipy',
        'numpy'
    ]
)
