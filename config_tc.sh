/sbin/tc qdisc del dev eno1 root handle 1
/sbin/tc qdisc add dev eno1 root handle 1: htb default 9999
/sbin/tc class add dev eno1 parent 1:0 classid 1:9999 htb rate 10000000kbit ceil 10000000kbit burst 5k prio 9999

# tc for hccltbrnet\\krbtgt:1
/sbin/tc class add dev eno1 parent 1:0 classid 1:1 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\wkleung:2
/sbin/tc class add dev eno1 parent 1:0 classid 1:2 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\citrixtest:3
/sbin/tc class add dev eno1 parent 1:0 classid 1:3 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\hmmeng.cuhk:4
/sbin/tc class add dev eno1 parent 1:0 classid 1:4 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\njzheng.cuhk:5
/sbin/tc class add dev eno1 parent 1:0 classid 1:5 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\jcli.cuhk:6
/sbin/tc class add dev eno1 parent 1:0 classid 1:6 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\xyliu.cuhk:7
/sbin/tc class add dev eno1 parent 1:0 classid 1:7 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\mwmak.polyu:8
/sbin/tc class add dev eno1 parent 1:0 classid 1:8 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\xqke.polyu:9
/sbin/tc class add dev eno1 parent 1:0 classid 1:9 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\ssxu.polyu:10
/sbin/tc class add dev eno1 parent 1:0 classid 1:10 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\bmak.ust:11
/sbin/tc class add dev eno1 parent 1:0 classid 1:11 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\cfhuang.ust:12
/sbin/tc class add dev eno1 parent 1:0 classid 1:12 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\mxj.ust:13
/sbin/tc class add dev eno1 parent 1:0 classid 1:13 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\khwong.cuhk:14
/sbin/tc class add dev eno1 parent 1:0 classid 1:14 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\hhlfung.cuhk:15
/sbin/tc class add dev eno1 parent 1:0 classid 1:15 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\tkwok.cuhk:16
/sbin/tc class add dev eno1 parent 1:0 classid 1:16 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\vctmok.cuhk:17
/sbin/tc class add dev eno1 parent 1:0 classid 1:17 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\pwong.cuhk:18
/sbin/tc class add dev eno1 parent 1:0 classid 1:18 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\jeanwoowong.cuhk:19
/sbin/tc class add dev eno1 parent 1:0 classid 1:19 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\kelvintsoi.cuhk:20
/sbin/tc class add dev eno1 parent 1:0 classid 1:20 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\peter:21
/sbin/tc class add dev eno1 parent 1:0 classid 1:21 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\katy:22
/sbin/tc class add dev eno1 parent 1:0 classid 1:22 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\cherry.lui.bdda.cuhk:23
/sbin/tc class add dev eno1 parent 1:0 classid 1:23 htb rate 10kbps ceil 10kbps

# tc for hccltbrnet\\jwkang.cuhk:24
/sbin/tc class add dev eno1 parent 1:0 classid 1:24 htb rate 10kbps ceil 10kbps