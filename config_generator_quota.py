#!/opt/anaconda3/bin/python
# refer to: https://www.digitalocean.com/community/tutorials/how-to-set-filesystem-quotas-on-ubuntu-18-04

quota_for_home_GB = 20
quota_for_ssd_GB = 300


def get_domain_users():
    import subprocess
    response = subprocess.check_output(['net', 'ads', 'USER'])
    return response.decode("utf-8").split()

# generate disk quota control cmdlets
def gen_setquota(user):
    # create folders if nonexistance
    comlets = []
    comlets.append(f"\n# setquota for {user}")
    comlets.append(f"setquota -u {user} {quota_for_home_GB*1024}M {quota_for_home_GB*1024}M 0 0 /home")
    comlets.append(f"setquota -u {user} {quota_for_ssd_GB*1024}M {quota_for_ssd_GB*1024}M 0 0 /media/storage-ssd")
    # limit the quota
    return comlets

if __name__ == "__main__":
    # Get users name by net ads USER
    users = get_domain_users()
    # exclude some users such as test...
    users_ex = ['Guest', "test0303", "hcclcitrix", "hccladmin"]
    for user in users_ex:
        if user in users:
            users.remove(user)
    print("Home directories for domain users after excluding some unused:")

    user_fullname = []
    for user in users:
        user_fullname.append("hccltbrnet\\\\"+user)
        print("hccltbrnet\\\\"+user)

    # user_fullname = ["hccltbrnet\\\\administrator"]
    # generate the commandlets
    comlets = []
    for index, name in enumerate(user_fullname, start=1):
        comlets.extend(gen_setquota(name))

    with open("config_setquota.sh", "w") as f:
        f.write("\n".join(comlets))