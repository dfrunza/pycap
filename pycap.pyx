from pycap cimport *


ctypedef long Pcap

cdef public enum:
    PYCAP_D_INOUT = PCAP_D_INOUT
    PYCAP_D_IN    = PCAP_D_IN
    PYCAP_D_OUT   = PCAP_D_OUT

def pycap_create(bytes source, bytearray errbuf):
    cdef pcap_t* pcap = pcap_create(source, errbuf)
    return <Pcap>pcap

def pycap_close(Pcap pcap):
    pcap_close(<pcap_t*>pcap)
    return

def pycap_set_snaplen(Pcap pcap, int snaplen):
    status = pcap_set_snaplen(<pcap_t*>pcap, snaplen)
    return status

def pycap_set_promisc(Pcap pcap, int promisc):
    status = pcap_set_promisc(<pcap_t*>pcap, promisc)
    return status

def pycap_set_immediate_mode(Pcap pcap, int immediate_mode):
    status = pcap_set_immediate_mode(<pcap_t*>pcap, immediate_mode)
    return status

def pycap_setnonblock(Pcap pcap, int nonblock, bytearray errbuf):
    status = pcap_setnonblock(<pcap_t*>pcap, nonblock, errbuf)
    return status

def pycap_setdirection(Pcap pcap, pcap_direction_t direction):
    status = pcap_setdirection(<pcap_t*>pcap, direction)
    return status

def pycap_activate(Pcap pcap):
    status = pcap_activate(<pcap_t*>pcap)
    return status

def pycap_sendpacket(Pcap pcap, bytes buf, int size):
    status = pcap_sendpacket(<pcap_t*>pcap, buf, size)
    return status

def pycap_next_ex(Pcap pcap):
    cdef pcap_pkthdr* hdr = <pcap_pkthdr*>0
    cdef const unsigned char* data = <const unsigned char*>0
    cdef bytes data_bytes = bytes()
    with nogil:
        status = pcap_next_ex(<pcap_t*>pcap, &hdr, &data)
    if status == 1:
        data_bytes = data[:hdr.caplen]
    return data_bytes

def pycap_get_selectable_fd(Pcap pcap):
    fd = pcap_get_selectable_fd(<pcap_t*>pcap)
    return fd
