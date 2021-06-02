#!/opt/anaconda3/bin/python
#%%
import subprocess
import pandas as pd
from pandas.errors import EmptyDataError
import os
import datetime as dt
from util import report_dir
import re
from collections import defaultdict


interval_min = 5
lines_command_history = interval_min * 100

file_timestamp = dt.datetime.today()
traffic_file = report_dir+"traffic_record_" + file_timestamp.strftime("%Y_%m") +".csv"
cmdhist_file = report_dir+"cmdhist_record_" + file_timestamp.strftime("%Y_%m") +".csv"

def get_new_traffic_record():
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
def get_history_commands_by_user(user: str, dt_start: dt.datetime):
    user = user.lower()
    file_name = f"/home/HCCLTBRNET/{user}/.bash_history"
    if not os.path.exists(file_name):
        return []

    lines = []
    with open(file_name, "r") as f:
        lines = f.readlines()[-lines_command_history:]

    start_epoch = dt_start.timestamp()
    cmdlets = []

    # 2021-04-29
    # add a sorting feature using pandas series 
    if len(lines) == 0 or len(lines) == 1:
        return cmdlets

    # if not lines[0].startswith("#"):
    #     lines = lines[1:]

    _cmd_hist_dict: Dict[int, str] = {}
    # for i in range(int(len(lines)/2)):
    #     _cmd_hist_dict[int(lines[i*2].strip("#"))] = lines[i*2+1].strip("\n")
    
    _ts_pattern = r"^#1[6|7][0-9]{8}\n$"
    _ts = None
    for _l in lines:
        if re.match(_ts_pattern, _l):
            _ts = int(_l.strip("#"))
        elif _ts:
            if _ts in _cmd_hist_dict:
                _cmd_hist_dict[_ts] = _cmd_hist_dict[_ts] + ", " + _l.strip('\n')
            else:
                _cmd_hist_dict[_ts] = _l.strip("\n")

    if len(_cmd_hist_dict) == 0:
        return cmdlets

    _cmd_hist_df = pd.Series(_cmd_hist_dict)
    
    # sort
    _cmd_hist_df = _cmd_hist_df.sort_index()

    # selection by label
    cmdlets = list(_cmd_hist_df.loc[start_epoch:].values)
    return cmdlets


    # deprecated from 2021-04-29
    for ind, line in enumerate(lines):
        if line.startswith("#"):
            if int(line.strip("#")) >= start_epoch:
                # start recording
                break
    else:
        return cmdlets

    for i in range(ind+1, len(lines)):
        if lines[i].startswith("#"):
            continue
        cmdlets.append(lines[i].strip("\n"))
    return cmdlets
    # response = subprocess.check_output(["sudo", "-u", user, "bash -i <<<history"])
    # response = subprocess.check_output(["sudo", "-u", user, 'bash',  '-i', '<<<history'])
    # response = subprocess.check_output(["sudo", "-u", user, 'bash',  '-i', '-c', 'history -r; history'])
    # subprocess.check_output(f"exit".split())
# print(get_history_commands_by_user("peter", dt.datetime.now()-dt.timedelta(hours=4)))

def get_new_cmdhist_record(dt_start: dt.datetime):
    with open(os.path.dirname(__file__)+os.sep+"monitored_user_list.txt", "r") as f:
        users = f.read().split("\n")
    new_row = {}
    for u in users:
        if u == "":
            continue
        cmdlets = get_history_commands_by_user(u, dt_start)
        new_row[u] = ", ".join(cmdlets)
    return new_row
#%%
if __name__ == "__main__":
    # print("*********  ", os.path.basename(__file__)+"  ",dt.datetime.now(), "  *********")

    # record the traffic
    try:
        records_pre = pd.read_csv(traffic_file, header=[0,1], index_col=0)
    except (EmptyDataError, FileNotFoundError) as e:
        records_pre = None
    dt_current, _new_row = get_new_traffic_record()
    new_record = pd.DataFrame(_new_row, index=[dt_current])
    
    if records_pre is None:
        records = new_record
    else:
        records_merge = [records_pre, new_record]
        records = pd.concat(records_merge)
    records.to_csv(traffic_file)
    # clear the statistics
    subprocess.check_output("/sbin/iptables -t mangle -Z".split())

    # record the cmdlets
    try:
        cmdhist_records_pre = pd.read_csv(cmdhist_file, index_col=0)
    except (EmptyDataError, FileNotFoundError) as e:
        cmdhist_records_pre = None
    start_dt = dt_current - dt.timedelta(minutes=interval_min)
    _new_cmdhist_record = get_new_cmdhist_record(start_dt)
    new_cmdhist_record = pd.DataFrame(_new_cmdhist_record, index=[dt_current])
    if cmdhist_records_pre is None:
        cmdhist_records = new_cmdhist_record
    else:
        cmdhist_records_merge = [cmdhist_records_pre, new_cmdhist_record]
        cmdhist_records = pd.concat(cmdhist_records_merge)
    cmdhist_records.to_csv(cmdhist_file)
    

    
    
