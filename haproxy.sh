#!/bin/bash

sudo add-apt-repository ppa:vbernat/haproxy-1.8
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
server VM0 10.24.19.25:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM1 10.24.19.26:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM2 10.24.19.27:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM3 10.24.19.28:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM4 10.24.19.29:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM5 10.24.19.30:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM6 10.24.19.31:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM7 10.24.19.32:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM8 10.24.19.33:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM9 10.24.19.34:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM10 10.24.19.35:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM11 10.24.19.36:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM12 10.24.19.37:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM13 10.24.19.38:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM14 10.24.19.39:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM15 10.24.19.40:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM16 10.24.19.41:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM17 10.24.19.42:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM18 10.24.19.43:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM19 10.24.19.44:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM20 10.24.19.45:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM21 10.24.19.46:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM22 10.24.19.47:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM23 10.24.19.48:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM24 10.24.19.49:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM25 10.24.19.50:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM26 10.24.19.51:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM27 10.24.19.52:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM28 10.24.19.53:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM29 10.24.19.54:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM30 10.24.19.55:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM31 10.24.19.56:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM32 10.24.19.57:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM33 10.24.19.58:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM34 10.24.19.59:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM35 10.24.19.60:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM36 10.24.19.61:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM37 10.24.19.62:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM38 10.24.19.63:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM39 10.24.19.64:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM40 10.24.19.65:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM41 10.24.19.66:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM42 10.24.19.67:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM43 10.24.19.68:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM44 10.24.19.69:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM45 10.24.19.70:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM46 10.24.19.71:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM47 10.24.19.72:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM48 10.24.19.73:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM49 10.24.19.74:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10
server VM50 10.24.19.75:3389 check fall 3 rise 5 inter 2000 maxconn 1 weight 10

" >> /etc/haproxy/haproxy.cfg

sudo haproxy -c -f /etc/haproxy/haproxy.cfg

sudo service haproxy restart