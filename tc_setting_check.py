#!/opt/anaconda3/bin/python

#%%
import subprocess
import os
import datetime as dt

# %%
response1 = subprocess.run("/sbin/tc -g -d qdisc show dev eno1".split(), capture_output=True)
is_qdisc_ok = response1.stdout.decode("utf-8").startswith("qdisc htb 1: root")
response2 = subprocess.run("/sbin/tc -g -d class show dev eno1".split(), capture_output=True)
is_class_ok= "htb" in response2.stdout.decode("utf-8").split("\n")[0]
if (not is_qdisc_ok) or (not is_class_ok):
    # has been reset to default
    # so call the tc script again
    print("*********  ", os.path.basename(__file__)+"  ",dt.datetime.now(), "  *********")
    print(subprocess.call(["sh", os.path.dirname(__file__)+os.sep+"config_tc.sh"]))

# %%
