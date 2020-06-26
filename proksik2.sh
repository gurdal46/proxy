#!/bin/bash
# Copyright
# Boris O. Baktashev
# http://kak-podnyat-proksi-ipv6.ru
# 2016


ipv4=185.118.66.108
port=30000
config="/root/3proxy/3proxy.cfg"


echo "daemon" >> $config
echo "maxconn 1000" >> $config
echo "nscache 65536" >> $config
echo "timeouts 1 5 30 60 180 1800 15 60" >> $config
echo "setgid 65535" >> $config
echo "setuid 65535" >> $config

for i in `cat ip.list`; do
    echo "auth strong
users user$inc:CL:`pwgen -N 1`
allow user$inc
proxy -n -a -6 -S8192 -i$ipv4 -e$i -p$port
flush" >> $config
    ((port+=1))
    ((inc+=1))
done
