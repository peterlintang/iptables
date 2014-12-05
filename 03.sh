#!/bin/bash
#
# we can ping others, but others can not ping us
#

#
# reset iptables
#
iptables -F
iptables -X
iptables -Z

#
# set default rules
# input output forward drop
#
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#
# enalbe loclal lo interface
#
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#
# allow established connects
#
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

#
# enable tcp port 22 and 80
#
iptables -A INPUT -p tcp -m multiport --dports 22,80 -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sports 22,80 -j ACCEPT

#
# allow icmp type 8 to out
# icmp type 0 to in
#
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 8 -j ACCEPT
