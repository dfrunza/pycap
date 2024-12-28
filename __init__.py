import sys

PYTHON_VERSION = '%s.%s' % (sys.version_info.major, sys.version_info.minor)

if PYTHON_VERSION == '3.6':
    from .pycap3_6 import *
elif PYTHON_VERSION == '3.8':
    from .pycap3_8 import *
elif PYTHON_VERSION == '3.10':
    from .pycap3_10 import *
else:
    raise NotImplementedError("'pycap' not supported in Python%s" % PYTHON_VERSION)

__all__ = [
    'PYCAP_D_INOUT',
    'PYCAP_D_IN',
    'PYCAP_D_OUT',

    'pycap_create',
    'pycap_close',
    'pycap_set_snaplen',
    'pycap_set_promisc',
    'pycap_set_immediate_mode',
    'pycap_setnonblock',
    'pycap_setdirection',
    'pycap_activate',
    'pycap_sendpacket',
    'pycap_next_ex',
    'pycap_get_selectable_fd',
]
