import os
import logging
import time
#logging.basicConfig(level=logging.INFO, filename="/opt/wg_reconnect/restarting.log",filemode="w", format="%(asctime)s %(levelname)s %(message)s")
from pythonping import ping

def reconnect():
    logging.warning('Ping fail! Restarting wireguard connection!')
    os.system('systemctl stop wg-quick@wg0.service')
    time.sleep(5)
    os.system('systemctl start wg-quick@wg0.service')


while True:
    try:
        if not ping('10.252.1.1')._responses[0].success:
            reconnect()
        time.sleep(60)
    except OSError:
        time.sleep(60)
        reconnect()
