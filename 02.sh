#!/bin/bash
#
# web server iptables
#

#
# clear iptables
#
iptables -F
iptables -X
iptables -Z

#
# set default
# input drop
# forward output accept
#
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

#
# allow lo input/output
#
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#
# for web server
#
iptables -A INPUT -p tcp -m multiport --dports 22,80 -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
