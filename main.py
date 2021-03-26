#!/opt/anaconda3/bin/python
from util import *
import config_generator_iptables
import config_generator_quota
import config_generator_tc
import disk_permissioni_mgmt
import subprocess
import os

def main():
    # run the generation scripts
    config_generator_iptables.main()
    config_generator_quota.main()
    config_generator_tc.main()

    # run the generated scripts
    subprocess.call(["sh", os.path.dirname(__file__)+os.sep+"config_iptables.sh"])
    subprocess.call(["sh", os.path.dirname(__file__)+os.sep+"config_setquota.sh"])
    subprocess.call(["sh", os.path.dirname(__file__)+os.sep+"config_tc.sh"])

    # disk permissioin management
    disk_permissioni_mgmt.main()

    # update the domain user list
    users = get_domain_users_monitored()
    with open("monitored_user_list.txt", "w") as f:
        f.write("\n".join(users)+"\n")


if __name__ == "__main__":
    main()