iptables -t mangle -F
iptables -t mangle -X
iptables -t mangle -Z

#whitelist tcp package without any payloads
#iptables -t mangle -A OUTPUT -p tcp -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -o eno1 -j ACCEPT

# tc for hccltbrnet\\Administrator:1
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\Administrator -j CLASSIFY --set-class 1:1
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\Administrator -j RETURN

# tc for hccltbrnet\\krbtgt:2
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\krbtgt -j CLASSIFY --set-class 1:2
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\krbtgt -j RETURN

# tc for hccltbrnet\\wkleung:3
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\wkleung -j CLASSIFY --set-class 1:3
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\wkleung -j RETURN

# tc for hccltbrnet\\citrixtest:4
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\citrixtest -j CLASSIFY --set-class 1:4
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\citrixtest -j RETURN

# tc for hccltbrnet\\hmmeng.cuhk:5
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\hmmeng.cuhk -j CLASSIFY --set-class 1:5
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\hmmeng.cuhk -j RETURN

# tc for hccltbrnet\\njzheng.cuhk:6
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\njzheng.cuhk -j CLASSIFY --set-class 1:6
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\njzheng.cuhk -j RETURN

# tc for hccltbrnet\\jcli.cuhk:7
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\jcli.cuhk -j CLASSIFY --set-class 1:7
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\jcli.cuhk -j RETURN

# tc for hccltbrnet\\xyliu.cuhk:8
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\xyliu.cuhk -j CLASSIFY --set-class 1:8
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\xyliu.cuhk -j RETURN

# tc for hccltbrnet\\mwmak.polyu:9
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\mwmak.polyu -j CLASSIFY --set-class 1:9
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\mwmak.polyu -j RETURN

# tc for hccltbrnet\\xqke.polyu:10
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\xqke.polyu -j CLASSIFY --set-class 1:10
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\xqke.polyu -j RETURN

# tc for hccltbrnet\\ssxu.polyu:11
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\ssxu.polyu -j CLASSIFY --set-class 1:11
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\ssxu.polyu -j RETURN

# tc for hccltbrnet\\bmak.ust:12
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\bmak.ust -j CLASSIFY --set-class 1:12
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\bmak.ust -j RETURN

# tc for hccltbrnet\\cfhuang.ust:13
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\cfhuang.ust -j CLASSIFY --set-class 1:13
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\cfhuang.ust -j RETURN

# tc for hccltbrnet\\mxj.ust:14
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\mxj.ust -j CLASSIFY --set-class 1:14
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\mxj.ust -j RETURN

# tc for hccltbrnet\\khwong.cuhk:15
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\khwong.cuhk -j CLASSIFY --set-class 1:15
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\khwong.cuhk -j RETURN

# tc for hccltbrnet\\hhlfung.cuhk:16
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\hhlfung.cuhk -j CLASSIFY --set-class 1:16
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\hhlfung.cuhk -j RETURN

# tc for hccltbrnet\\tkwok.cuhk:17
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\tkwok.cuhk -j CLASSIFY --set-class 1:17
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\tkwok.cuhk -j RETURN

# tc for hccltbrnet\\vctmok.cuhk:18
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\vctmok.cuhk -j CLASSIFY --set-class 1:18
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\vctmok.cuhk -j RETURN

# tc for hccltbrnet\\pwong.cuhk:19
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\pwong.cuhk -j CLASSIFY --set-class 1:19
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\pwong.cuhk -j RETURN

# tc for hccltbrnet\\jeanwoowong.cuhk:20
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\jeanwoowong.cuhk -j CLASSIFY --set-class 1:20
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\jeanwoowong.cuhk -j RETURN

# tc for hccltbrnet\\kelvintsoi.cuhk:21
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\kelvintsoi.cuhk -j CLASSIFY --set-class 1:21
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\kelvintsoi.cuhk -j RETURN

# tc for hccltbrnet\\peter:22
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\peter -j CLASSIFY --set-class 1:22
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\peter -j RETURN

# tc for hccltbrnet\\katy:23
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\katy -j CLASSIFY --set-class 1:23
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\katy -j RETURN

# tc for hccltbrnet\\cherry.lui.bdda.cuhk:24
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\cherry.lui.bdda.cuhk -j CLASSIFY --set-class 1:24
iptables -t mangle -A OUTPUT -p all -o eno1 ! -d 192.168.150.0/24 -m owner --uid-owner hccltbrnet\\cherry.lui.bdda.cuhk -j RETURN
netfilter-persistent save