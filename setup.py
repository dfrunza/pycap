import sys
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

PYLIB_VERSION = '%s.%s' % (sys.version_info.major, sys.version_info.minor)
PYMOD_VERSION = '%s_%s' % (sys.version_info.major, sys.version_info.minor)


setup(
    name = "pycap",

    ext_modules = cythonize([
        Extension('pycap%s' % PYMOD_VERSION, ['pycap.pyx'],
            libraries = ['pcap', 'python%s' % PYLIB_VERSION],
            include_dirs = [
              'runtime/include',
              'runtime/include/' + 'python%s' % PYLIB_VERSION,
              'runtime/include/pcap'],
            library_dirs = ['runtime/lib'],
            # extra_compile_args = [],
            # extra_link_args = []
        )],
        compiler_directives = {
            'language_level': '3',
        },
        build_dir = 'build',
        # gdb_debug = True
    )
)

