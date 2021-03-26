#!/opt/anaconda3/bin/python

import os
from typing import List
def get_immediate_subdirectories(a_dir) -> List[str]:
    return [name for name in os.listdir(a_dir) if os.path.isdir(os.path.join(a_dir,name))]
import subprocess


# parameters
interface = "eno1"
max_bandwidth_kbps = 10000000
max_bandwidth_kbps_for_each_user = 10


whitelist = []
restrictedlist = []
blacklist = []


# generate traffic control cmdlets
def gen_tc_by_user(user:str, seq:int):
    comlets = []
    comlets.append(f"\n# tc for {user}:{seq}")
    comlets.append(f"/sbin/tc class add dev {interface} parent 1:0 classid 1:{seq} htb rate {max_bandwidth_kbps_for_each_user}kbps ceil {max_bandwidth_kbps_for_each_user}kbps")
    return comlets


# reset the config
def reset_tc():
    comlets = []
    comlets.append(f"/sbin/tc qdisc del dev {interface} root handle 1")
    comlets.append(f"/sbin/tc qdisc add dev {interface} root handle 1: htb default 9999")
    # create the default class
    comlets.append(f"/sbin/tc class add dev {interface} parent 1:0 classid 1:9999 htb rate {max_bandwidth_kbps}kbit ceil {max_bandwidth_kbps}kbit burst 5k prio 9999")
    
    return comlets


def main():
    # Get users name by net ads USER
    from util import get_domain_users_monitored
    users = get_domain_users_monitored()
    user_fullname = []
    for user in users:
        user_fullname.append("hccltbrnet\\\\"+user)
        print("hccltbrnet\\\\"+user)

    # user_fullname = ["hccltbrnet\\\\administrator"]
    # generate the commandlets
    comlets = []
    comlets.extend(reset_tc())
    for index, name in enumerate(user_fullname, start=1):
        comlets.extend(gen_tc_by_user(name, index))

    with open("config_tc.sh", "w") as f:
        f.write("\n".join(comlets))

    
    # for cmd in comlets:
    #     if cmd.strip().startswith('#') or cmd.strip() == '':
    #         continue
    #     cmd.replace("\\\\", "\\")
    #     subprocess.call(cmd.split())
    

# %%
