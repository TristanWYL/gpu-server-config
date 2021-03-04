#!/opt/anaconda3/bin/python
#%%
import subprocess
import pandas as pd
from pandas.errors import EmptyDataError
import os
import datetime as dt


csv_file = os.path.dirname(__file__)+os.sep+"traffic_record.csv"

def get_new_record():
    response = subprocess.check_output("/sbin/iptables -t mangle -L OUTPUT -x -v".split())
    response_dec = response.decode("utf-8").split("\n")
    new_row = {}
    new_row["time"] = dt.datetime.now()
    for r in response_dec[2::2]:
        # print(r)
        datum = r.split()
        if len(datum) > 12:
            new_row[datum[12]] = datum[1]
    return new_row

#%%
if __name__ == "__main__":
    print("*********  ", os.path.basename(__file__)+"  ",dt.datetime.now(), "  *********")
    try:
        records_pre = pd.read_csv(csv_file)
    except EmptyDataError:
        records_pre = None
    new_row = pd.DataFrame(get_new_record(), index=[0])
    
    if records_pre is None:
        records = new_row
    else:
        records_merge = [records_pre, new_row]
        records = pd.concat(records_merge)
    records.to_csv(csv_file, index=False)

    # clear the statistics
    subprocess.check_output("/sbin/iptables -t mangle -Z".split())
    
