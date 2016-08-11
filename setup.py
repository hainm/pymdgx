import os
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

amberhome = os.environ.get('AMBERHOME')
libdir = os.path.join(amberhome, 'lib')
extra_compile_args = []

cython_directives = {
    'embedsignature': True,
    'boundscheck': False,
    'wraparound': False,
}

ext = Extension(
        "cutil",
        ["cutil.pyx",],
        libraries=['mdgx', 'netcdf',],
        library_dirs=[libdir,],
        include_dirs=[amberhome + '/include/',],
        extra_compile_args=extra_compile_args,
        extra_link_args=extra_compile_args,
        )

setup(
    ext_modules=cythonize([ext, ],
        compiler_directives=cython_directives,
        ),
)
