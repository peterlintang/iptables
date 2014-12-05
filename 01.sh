#!/bin/bash

#
# only we to connect pc, not allow others connect us
#
iptables -F	# delete all rules of tables
iptables -X
iptables -Z	# zero counters

iptables -P INPUT DROP	# default drop input packets
iptables -A INPUT -i lo -j ACCEPT	# allow local interface	
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -m state --state NEW -j DROP	# drop new connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
