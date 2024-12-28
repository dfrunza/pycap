from pycap import *
from select import select
from scapy.all import Ether, IP, UDP, Raw

pcap = pycap_create(b"veth1", errbuf=bytearray(256))
status = pycap_set_snaplen(pcap, 65536)
status = pycap_set_promisc(pcap, True)
status = pycap_set_immediate_mode(pcap, True)
status = pycap_activate(pcap)

status = pycap_setnonblock(pcap, False, errbuf=bytearray(256))
status = pycap_setdirection(pcap, PYCAP_D_IN)
devfd = pycap_get_selectable_fd(pcap)


def main():
    #packet_tx = Ether(dst="a0:aa:aa:aa:aa:aa", src="b0:bb:bb:bb:bb:bb") / \
    #         IP(src="1.1.1.1", dst="2.2.2.2") / \
    #         UDP(sport=2111, dport=2222) / \
    #         Raw("Hello PyCap")
    #
    #for i in range(10):
    #  status = pycap_sendpacket(pcap, bytes(packet_tx), len(packet_tx))

    counter = 0
    while True:
        (rlist, wlist, xlist) = select([devfd], [], [], 1.0)
        if len(rlist) == 0: continue
        data = pycap_next_ex(pcap)
        if len(data) == 0: continue  # 0x9000 loopback keepalive
        packet_rx = Ether(data)
        packet_rx.show()
        counter += 1
        print("-"*20 + f"  {counter}  " + "-"*20)
    return

try:
    main()
except KeyboardInterrupt:
    print()  # \n
