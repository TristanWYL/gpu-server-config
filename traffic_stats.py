#!/opt/anaconda3/bin/python
#%%
import subprocess
import pandas as pd
from pandas.errors import EmptyDataError
import os
import datetime as dt

report_dir = os.path.dirname(__file__)+os.sep+"report"+os.sep
traffic_file = report_dir+"traffic_record_" + dt.datetime.today().strftime("%Y_%m") +".csv"

def get_new_record():
    response = subprocess.check_output("/sbin/iptables -t mangle -L OUTPUT -x -v".split())
    response_dec = response.decode("utf-8").split("\n")
    new_row = {}
    sublists = [response_dec[i:i+2] for i in range(3, len(response_dec)-1, 3)]
    for sublist in sublists:
        data_tcp_without_payload = sublist[0].split()
        data_others = sublist[1].split()
        user = data_tcp_without_payload[-1]
        if len(data_tcp_without_payload) > 12:
            new_row[(user,"tcp_without_payload")] = data_tcp_without_payload[1]
            new_row[(user,"others")] = data_others[1]
    return dt.datetime.now(), new_row

#%%
# get history commands by user
import subprocess
def get_history_commands_by_user(user: str, dt_start: dt.datetime, dt_end: dt.datetime=None):
    file_name = f"/home/HCCLTBRNET/{user}/.bash_history"
    cmds = []
    with open(file_name, "r") as f:
        cmdlets = []
        _start = None
        for line in f:
            if line.startswith("#"):
                _start = dt.datetime.fromtimestamp(line.strip("#"))
            else:
                cmdlets.append(line)
            if dt_end is not None:
                if _start > dt_end:
                    break
            if _start is not None:
                cmds.extend(cmdlets)
    return cmds
    # response = subprocess.check_output(["sudo", "-u", user, "bash -i <<<history"])
    # response = subprocess.check_output(["sudo", "-u", user, 'bash',  '-i', '<<<history'])
    # response = subprocess.check_output(["sudo", "-u", user, 'bash',  '-i', '-c', 'history -r; history'])
    # subprocess.check_output(f"exit".split())
# print(get_history_commands_by_user("peter"))
#%%
if __name__ == "__main__":
    # print("*********  ", os.path.basename(__file__)+"  ",dt.datetime.now(), "  *********")

    # record the traffic
    try:
        records_pre = pd.read_csv(traffic_file, header=[0,1], index_col=0)
    except (EmptyDataError, FileNotFoundError) as e:
        records_pre = None
    _dt, _new_row = get_new_record()
    new_record = pd.DataFrame(_new_row, index=[_dt])
    
    if records_pre is None:
        records = new_record
    else:
        records_merge = [records_pre, new_record]
        records = pd.concat(records_merge)
    records.to_csv(traffic_file)
    # clear the statistics
    subprocess.check_output("/sbin/iptables -t mangle -Z".split())

    # record the cmdlets
    # from util import get_domain_users_monitored
    # users = get_domain_users_monitored()
    

    
    
