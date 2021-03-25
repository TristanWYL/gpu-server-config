#!/opt/anaconda3/bin/python

import os
import subprocess


# parameters
interface = "eno1"
max_bandwidth_kbps = 10000000
max_bandwidth_kbps_for_each_user = 10


whitelist = []
restrictedlist = []
blacklist = []


def gen_tc():
    comlets = []

    # whitelist packets running internally
    comlets.append(f"\n#whitelist packets running internally")
    comlets.append(f"iptables -t mangle -A OUTPUT -p all -o {interface} -d 192.168.150.0/24 -j ACCEPT")

    # whitelist package without any payloads
    comlets.append(f"\n#whitelist tcp package without any payloads")
    # -u32 "6 & 0xFF = 6" means tcp
    # -u32 "6 & 0xFF = 17" means udp
    comlets.append(f"#iptables -t mangle -A OUTPUT -p tcp -m u32 ! --u32 \"0>>22&0x3C@12>>26&0x3C@0=0:4294967295\" -o {interface} -j ACCEPT")

    # whitelist ACK packages
    # comlets.append(f"iptables -t mangle -A OUTPUT -p tcp -m length --length 1:100 -o {interface} -j ACCEPT")

    # whitelist per dst
    if len(whitelist)>0:
        dst = ",".join(whitelist)
        comlets.append(f"iptables -t mangle -A OUTPUT -p tcp -o {interface} -d {dst} -j ACCEPT")

    return comlets


# generate traffic control cmdlets
def gen_tc_by_user(user:str, seq:int):
    comlets = []
    comlets.append(f"\n# tc for {user}:{seq}")
    # whitelist package without any payloads
    comlets.append(f"# whitelist tcp package without any payloads")
    comlets.append(f"iptables -t mangle -A OUTPUT -p tcp -m u32 ! --u32 \"0>>22&0x3C@12>>26&0x3C@0=0:4294967295\" -m owner --uid-owner {user} -o {interface} -j ACCEPT")
    comlets.append(f"iptables -t mangle -A OUTPUT -p all -o {interface} -m owner --uid-owner {user} -j CLASSIFY --set-class 1:{seq}")
    comlets.append(f"iptables -t mangle -A OUTPUT -p all -o {interface} -m owner --uid-owner {user} -j ACCEPT")
    return comlets




# reset the config
def reset_tc():
    comlets = []
    comlets.append("iptables -t mangle -F")
    comlets.append("iptables -t mangle -X")
    comlets.append("iptables -t mangle -Z")
    return comlets


def get_domain_users():
    import subprocess
    response = subprocess.check_output(['net', 'ads', 'USER'])
    return response.decode("utf-8").split()

# print(get_domain_users())
if __name__ == "__main__":
    from util import get_domain_users_monitored
    # Get users name by net ads USER
    users = get_domain_users_monitored()

    user_fullname = []
    for user in users:
        user_fullname.append("hccltbrnet\\\\"+user)
        print("hccltbrnet\\\\"+user)

    # user_fullname = ["hccltbrnet\\\\administrator"]
    # generate the commandlets
    comlets = []
    comlets.extend(reset_tc())
    comlets.extend(gen_tc())
    for index, name in enumerate(user_fullname, start=1):
        comlets.extend(gen_tc_by_user(name, index))
    # save the iptables
    comlets.append("netfilter-persistent save")

    with open("config_iptables.sh", "w") as f:
        f.write("\n".join(comlets))

    
    # for cmd in comlets:
    #     if cmd.strip().startswith('#') or cmd.strip() == '':
    #         continue
    #     cmd.replace("\\\\", "\\")
    #     subprocess.call(cmd.split())
    

# %%
