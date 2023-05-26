#!/bin/sh
service ssh start

sed -i "s@LDAP_BIND_DN@${LDAP_BIND_DN}@" /etc/nslcd.conf
sed -i "s@LDAP_BIND_PASSWORD@${LDAP_BIND_PASSWORD}@" /etc/nslcd.conf
sed -i "s@LDAP_URI@${LDAP_URI}@" /etc/nslcd.conf
sed -i "s@LDAP_BASE@${LDAP_BASE}@" /etc/nslcd.conf
sed -i "s@ikey =@ikey = ${DUO_INTEGRATION_KEY}@" /etc/duo/pam_duo.conf
sed -i "s@skey =@skey = ${DUO_SECRET_KEY}@" /etc/duo/pam_duo.conf
sed -i "s@host =@host = ${DUO_HOST}@" /etc/duo/pam_duo.conf

nslcd -d
