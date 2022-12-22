#!/bin/bash

sudo add-apt-repository ppa:vbernat/haproxy-2.7
sudo apt-get update
sudo apt-get install haproxy

sudo echo "
global
daemon
stats socket /var/run/haproxy.sock mode 777 level admin
maxconn 4096
maxcompcpuusage 100
maxcomprate 0
nbproc 1
ssl-server-verify required
log 127.0.0.1:29987 local0


defaults
mode tcp
option http-server-close
option redispatch
retries 3
timeout connect 5000
timeout server 50000
timeout client 50000
timeout check 50000
timeout http-keep-alive 50000
timeout http-request 50000
log global


listen RDP
bind 0.0.0.0:3389
balance leastconn
maxconn 50000
mode tcp
timeout connect 500000
timeout client 500000
timeout server 500000
option persist
tcp-request content accept if RDP_COOKIE
tcp-request inspect-delay 5s
option tcpka
server VM0 192.168.100.116:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM1 192.168.100.117:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM2 192.168.100.118:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM3 192.168.100.119:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10

" >> /etc/haproxy/haproxy.cfg

sudo haproxy -c -f /etc/haproxy/haproxy.cfg

sudo service haproxy restart