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
    comlets.append(f"iptables -t mangle -A OUTPUT -p all -o {interface} ! -d 192.168.150.0/24 -m owner --uid-owner {user} -j CLASSIFY --set-class 1:{seq}")
    comlets.append(f"iptables -t mangle -A OUTPUT -p all -o {interface} ! -d 192.168.150.0/24 -m owner --uid-owner {user} -j RETURN")
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

    # Get users name by net ads USER
    homes = get_domain_users()
    # exclude some users such as test...
    homes_ex = ['Guest', "test0303", "hcclcitrix", "hccladmin"]
    for home in homes_ex:
        if home in homes:
            homes.remove(home)
    print("Home directories for domain users after excluding some unused:")

    home_fullname = []
    for home in homes:
        home_fullname.append("hccltbrnet\\\\"+home)
        print("hccltbrnet\\\\"+home)

    # home_fullname = ["hccltbrnet\\\\administrator"]
    # generate the commandlets
    comlets = []
    comlets.extend(reset_tc())
    comlets.extend(gen_tc())
    for index, name in enumerate(home_fullname, start=1):
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
