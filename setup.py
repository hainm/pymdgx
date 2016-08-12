import os
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

amberhome = os.environ.get('AMBERHOME')
libdir = os.path.join(amberhome, 'lib')
extra_compile_args = ['-O0', '-ggdb']
extra_link_args = ['-O0', '-ggdb']

cython_directives = {
    'embedsignature': True,
    'boundscheck': False,
    'wraparound': False,
}

ext = Extension(
        "mdgx.mdgx",
        ["mdgx/mdgx.pyx",],
        libraries=['mdgx', 'netcdf',],
        library_dirs=[libdir,],
        include_dirs=[amberhome + '/include/',],
        extra_compile_args=extra_compile_args,
        extra_link_args=extra_link_args,
        )

setup(
    name='mdgx',
    packages=['mdgx'],
    version='0.0.1',
    ext_modules=cythonize([ext, ],
        compiler_directives=cython_directives,
    ),
)
