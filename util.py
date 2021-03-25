

def get_domain_users():
    import subprocess
    response = subprocess.check_output(['net', 'ads', 'USER'])
    return response.decode("utf-8").split()


# exclude some users such as test...
def get_domain_users_monitored():
    users = get_domain_users()
    users_ex = ['Guest', "test0303", "hcclcitrix", "hccladmin"]
    for user in users_ex:
        if user in users:
            users.remove(user)
    return users


