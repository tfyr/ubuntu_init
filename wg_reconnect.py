import os
import logging
import time
#logging.basicConfig(level=logging.INFO, filename="/opt/wg_reconnect/restarting.log",filemode="w", format="%(asctime)s %(levelname)s %(message)s")
from pythonping import ping
while True:
    if not ping('10.252.1.1')._responses[0].success:
        logging.warning('Ping fail! Restarting wireguard connection!')
        os.system('systemctl stop wg-quick@wg0.service')
        time.sleep(5)
        os.system('systemctl start wg-quick@wg0.service')
    time.sleep(60)
