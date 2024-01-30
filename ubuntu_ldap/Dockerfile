FROM ubuntu:22.04

RUN apt update \
 && DEBIAN_FRONTEND=noninteractive apt -y install openssh-server sudo nscd libnss-ldapd libpam-ldapd libuser curl gpg vim

RUN sed -i 's@uri ldap://127.0.0.1/@uri LDAP_URI@' /etc/nslcd.conf \
 && sed -i 's@base dc=example,dc=net@base LDAP_BASE@' /etc/nslcd.conf \
 && sed -i 's@#binddn cn=annonymous,dc=example,dc=net@binddn LDAP_BIND_DN@' /etc/nslcd.conf \
 && sed -i 's@#bindpw secret@bindpw LDAP_BIND_PASSWORD@' /etc/nslcd.conf \
 && echo 'filter passwd (Objectclass=user) \n\
map    passwd uid           sAMAccountName \n\
map    passwd uidNumber     objectSid:S-1-5-21-1391733952-3059161487-1245441232 \n\
map    passwd gidNumber     objectSid:S-1-5-21-1391733952-3059161487-1245441232 \n\
map    passwd homeDirectory "/home/$sAMAccountName" \n\
map    passwd gecos         displayName \n\
map    passwd loginShell    "/bin/bash"' >> /etc/nslcd.conf \
 && sed -i 's@passwd:         files systemd@passwd:         files systemd ldap@' /etc/nsswitch.conf \
 && sed -i 's@group:          files systemd@group:          files systemd ldap@' /etc/nsswitch.conf \
 && sed -i 's@shadow:         files systemd@shadow:         files systemd ldap@' /etc/nsswitch.conf

RUN echo 'deb [arch=amd64] https://pkg.duosecurity.com/Ubuntu jammy main' > /etc/apt/sources.list.d/duosecurity.list \
 && curl -s https://duo.com/DUO-GPG-PUBLIC-KEY.asc | sudo gpg --dearmor -o  /etc/apt/trusted.gpg.d/duo.gpg \
 && apt update \
 && apt -y install duo-unix \
 && echo 'groups=ldap_users,!duo_exempt' >> /etc/duo/pam_duo.conf \
 && sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config \
 && sed -i 's%@include common-auth%@include common-auth\nauth  [success=1 default=ignore] /lib64/security/pam_duo.so\nauth  requisite pam_deny.so\nauth  required pam_permit.so%' /etc/pam.d/sshd

RUN addgroup duo_exempt \
 && addgroup ldap_users \
 && useradd -rm -d /home/local_user -s /bin/bash -g root -G sudo -u 1000 local_user \
 && echo 'local_user:p4ssw0rd' | chpasswd

COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
