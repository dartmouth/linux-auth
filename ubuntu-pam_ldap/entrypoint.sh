#!/bin/sh
service ssh start

sed -i "s@LDAP_BIND_DN@${LDAP_BIND_DN}@" /etc/nslcd.conf
sed -i "s@LDAP_BIND_PASSWORD@${LDAP_BIND_PASSWORD}@" /etc/nslcd.conf
sed -i "s@LDAP_URI@${LDAP_URI}@" /etc/nslcd.conf

nslcd -d
