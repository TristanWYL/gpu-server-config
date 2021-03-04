#!/opt/anaconda3/bin/python

# %%
import os
from typing import List
import subprocess

# subprocess.run("chown administrator:root /media/storage-ssd/peter.test".split())

# %%
def get_immediate_subdirectories(a_dir) -> List[str]:
    return [name for name in os.listdir(a_dir) if os.path.isdir(os.path.join(a_dir,name))]

def get_domain_users():
    import subprocess
    response = subprocess.check_output(['net', 'ads', 'USER'])
    return response.decode("utf-8").split()

disk = "/media/storage-ssd"
existing_folders = get_immediate_subdirectories(disk)

def gen_folder_mgmt_by_user(user):
    # check file existence
    if user not in existing_folders:
        new_dir = disk+os.sep+user
        os.mkdir(new_dir)
        subprocess.run(f"chmod 755 {new_dir}".split())
        subprocess.run(f"chown {user}:root {new_dir}".split())

# print(get_domain_users())
if __name__ == "__main__":
    # Get users name by net ads USER
    users = get_domain_users()
    # exclude some users such as test...
    users_ex = ['Guest', "test0303", "hcclcitrix", "hccladmin"]
    for user in users_ex:
        if user in users:
            users.remove(user)

    # user_fullname = []
    # for user in users:
    #     user_fullname.append("hccltbrnet\\\\"+user)
    #     print("hccltbrnet\\\\"+user)

    # user_fullname = ["hccltbrnet\\\\administrator"]
    # generate the commandlets
    comlets = []
    for index, name in enumerate(users, start=1):
        gen_folder_mgmt_by_user(name)

