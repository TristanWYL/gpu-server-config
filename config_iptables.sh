iptables -t mangle -F
iptables -t mangle -X
iptables -t mangle -Z

#whitelist packets running internally
iptables -t mangle -A OUTPUT -p all -d 192.168.150.0/24 -j ACCEPT

#whitelist tcp package without any payloads
#iptables -t mangle -A OUTPUT -p tcp -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -o eno1 -j ACCEPT

# tc for hccltbrnet\\Administrator:1
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\Administrator -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\Administrator -j CLASSIFY --set-class 1:1
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\Administrator -j ACCEPT

# tc for hccltbrnet\\krbtgt:2
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\krbtgt -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\krbtgt -j CLASSIFY --set-class 1:2
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\krbtgt -j ACCEPT

# tc for hccltbrnet\\wkleung:3
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\wkleung -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\wkleung -j CLASSIFY --set-class 1:3
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\wkleung -j ACCEPT

# tc for hccltbrnet\\citrixtest:4
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\citrixtest -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\citrixtest -j CLASSIFY --set-class 1:4
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\citrixtest -j ACCEPT

# tc for hccltbrnet\\hmmeng.cuhk:5
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\hmmeng.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\hmmeng.cuhk -j CLASSIFY --set-class 1:5
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\hmmeng.cuhk -j ACCEPT

# tc for hccltbrnet\\njzheng.cuhk:6
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\njzheng.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\njzheng.cuhk -j CLASSIFY --set-class 1:6
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\njzheng.cuhk -j ACCEPT

# tc for hccltbrnet\\jcli.cuhk:7
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\jcli.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\jcli.cuhk -j CLASSIFY --set-class 1:7
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\jcli.cuhk -j ACCEPT

# tc for hccltbrnet\\xyliu.cuhk:8
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\xyliu.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\xyliu.cuhk -j CLASSIFY --set-class 1:8
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\xyliu.cuhk -j ACCEPT

# tc for hccltbrnet\\mwmak.polyu:9
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\mwmak.polyu -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\mwmak.polyu -j CLASSIFY --set-class 1:9
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\mwmak.polyu -j ACCEPT

# tc for hccltbrnet\\xqke.polyu:10
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\xqke.polyu -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\xqke.polyu -j CLASSIFY --set-class 1:10
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\xqke.polyu -j ACCEPT

# tc for hccltbrnet\\ssxu.polyu:11
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\ssxu.polyu -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\ssxu.polyu -j CLASSIFY --set-class 1:11
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\ssxu.polyu -j ACCEPT

# tc for hccltbrnet\\bmak.ust:12
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\bmak.ust -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\bmak.ust -j CLASSIFY --set-class 1:12
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\bmak.ust -j ACCEPT

# tc for hccltbrnet\\cfhuang.ust:13
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\cfhuang.ust -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\cfhuang.ust -j CLASSIFY --set-class 1:13
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\cfhuang.ust -j ACCEPT

# tc for hccltbrnet\\mxj.ust:14
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\mxj.ust -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\mxj.ust -j CLASSIFY --set-class 1:14
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\mxj.ust -j ACCEPT

# tc for hccltbrnet\\khwong.cuhk:15
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\khwong.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\khwong.cuhk -j CLASSIFY --set-class 1:15
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\khwong.cuhk -j ACCEPT

# tc for hccltbrnet\\hhlfung.cuhk:16
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\hhlfung.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\hhlfung.cuhk -j CLASSIFY --set-class 1:16
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\hhlfung.cuhk -j ACCEPT

# tc for hccltbrnet\\tkwok.cuhk:17
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\tkwok.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\tkwok.cuhk -j CLASSIFY --set-class 1:17
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\tkwok.cuhk -j ACCEPT

# tc for hccltbrnet\\vctmok.cuhk:18
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\vctmok.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\vctmok.cuhk -j CLASSIFY --set-class 1:18
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\vctmok.cuhk -j ACCEPT

# tc for hccltbrnet\\pwong.cuhk:19
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\pwong.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\pwong.cuhk -j CLASSIFY --set-class 1:19
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\pwong.cuhk -j ACCEPT

# tc for hccltbrnet\\jeanwoowong.cuhk:20
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\jeanwoowong.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\jeanwoowong.cuhk -j CLASSIFY --set-class 1:20
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\jeanwoowong.cuhk -j ACCEPT

# tc for hccltbrnet\\kelvintsoi.cuhk:21
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\kelvintsoi.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\kelvintsoi.cuhk -j CLASSIFY --set-class 1:21
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\kelvintsoi.cuhk -j ACCEPT

# tc for hccltbrnet\\peter:22
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\peter -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\peter -j CLASSIFY --set-class 1:22
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\peter -j ACCEPT

# tc for hccltbrnet\\katy:23
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\katy -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\katy -j CLASSIFY --set-class 1:23
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\katy -j ACCEPT

# tc for hccltbrnet\\cherry.lui.bdda.cuhk:24
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\cherry.lui.bdda.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\cherry.lui.bdda.cuhk -j CLASSIFY --set-class 1:24
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\cherry.lui.bdda.cuhk -j ACCEPT

# tc for hccltbrnet\\jwkang.cuhk:25
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\jwkang.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\jwkang.cuhk -j CLASSIFY --set-class 1:25
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\jwkang.cuhk -j ACCEPT

# tc for hccltbrnet\\helper01:26
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\helper01 -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\helper01 -j CLASSIFY --set-class 1:26
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\helper01 -j ACCEPT

# tc for hccltbrnet\\helper02:27
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\helper02 -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\helper02 -j CLASSIFY --set-class 1:27
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\helper02 -j ACCEPT

# tc for hccltbrnet\\luhui.cuhk:28
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\luhui.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\luhui.cuhk -j CLASSIFY --set-class 1:28
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\luhui.cuhk -j ACCEPT

# tc for hccltbrnet\\mlwu.cuhk:29
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\mlwu.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\mlwu.cuhk -j CLASSIFY --set-class 1:29
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\mlwu.cuhk -j ACCEPT

# tc for hccltbrnet\\kzhang.cuhk:30
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\kzhang.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\kzhang.cuhk -j CLASSIFY --set-class 1:30
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\kzhang.cuhk -j ACCEPT

# tc for hccltbrnet\\gnli.cuhk:31
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\gnli.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\gnli.cuhk -j CLASSIFY --set-class 1:31
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\gnli.cuhk -j ACCEPT

# tc for hccltbrnet\\zye.cuhk:32
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\zye.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\zye.cuhk -j CLASSIFY --set-class 1:32
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\zye.cuhk -j ACCEPT

# tc for hccltbrnet\\zding:33
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\zding -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\zding -j CLASSIFY --set-class 1:33
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\zding -j ACCEPT

# tc for hccltbrnet\\angelto.cuhk:34
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\angelto.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\angelto.cuhk -j CLASSIFY --set-class 1:34
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\angelto.cuhk -j ACCEPT

# tc for hccltbrnet\\garyleung.cuhk:35
# whitelist tcp package without any payloads
iptables -t mangle -A OUTPUT -p tcp -o eno1 -m u32 ! --u32 "0>>22&0x3C@12>>26&0x3C@0=0:4294967295" -m owner --uid-owner hccltbrnet\\garyleung.cuhk -j ACCEPT
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\garyleung.cuhk -j CLASSIFY --set-class 1:35
iptables -t mangle -A OUTPUT -p all -o eno1 -m owner --uid-owner hccltbrnet\\garyleung.cuhk -j ACCEPT
netfilter-persistent save