cdef extern from "sys/time.h":

    cdef struct timeval:
        pass

cdef extern from "pcap.h":

    ctypedef struct pcap_t:
        pass

    cdef struct pcap_pkthdr:
        timeval ts              # time stamp
        unsigned int caplen     # length of portion present
        unsigned int len        # length this packet (off wire)

    ctypedef enum pcap_direction_t:
        PCAP_D_INOUT = 0,
        PCAP_D_IN,
        PCAP_D_OUT

    pcap_t* pcap_create(const char*, char*) nogil;
    void pcap_close(pcap_t*) nogil;
    int pcap_set_snaplen(pcap_t*, int) nogil;
    int pcap_set_promisc(pcap_t*, int) nogil;
    int pcap_set_immediate_mode(pcap_t*, int) nogil;
    int pcap_setnonblock(pcap_t*, int, char*) nogil;
    int pcap_setdirection(pcap_t*, pcap_direction_t) nogil;
    int pcap_activate(pcap_t*) nogil;
    int pcap_sendpacket(pcap_t*, const unsigned char*, int) nogil;
    int pcap_next_ex(pcap_t*, pcap_pkthdr**, const unsigned char**) nogil;
    int pcap_get_selectable_fd(pcap_t*) nogil;
