#!/opt/anaconda3/bin/python
import os
#%%
def get_domain_users():
    import subprocess
    response = subprocess.check_output(['net', 'ads', 'USER'])
    return response.decode("utf-8").split()


# exclude some users such as test...
def get_domain_users_monitored():
    users = get_domain_users()
    users_ex = ['Guest', "test0303", "hcclcitrix", "hccladmin", "Administrator"]
    for user in users_ex:
        if user in users:
            users.remove(user)
    return users


report_dir = os.path.dirname(__file__)+os.sep+"report"+os.sep
#%%
if __name__ == "__main__":
    print(get_domain_users())



# %%
