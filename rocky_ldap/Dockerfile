FROM rockylinux:8.7

RUN dnf update -y \
 && dnf -y install openssh-server nss-pam-ldapd nscd passwd vim procps

RUN sed -i 's@^uri ldap://127.0.0.1/@uri LDAP_URI@' /etc/nslcd.conf \
 && sed -i 's@base dc=example,dc=com@base LDAP_BASE_DN@' /etc/nslcd.conf \
 && sed -i 's@#binddn cn=proxyuser,dc=example,dc=com@binddn LDAP_BIND_DN@' /etc/nslcd.conf \
 && sed -i 's@#bindpw secret@bindpw LDAP_BIND_PASSWORD@' /etc/nslcd.conf \
 && sed -i 's@passwd:      sss files systemd@passwd:      sss files systemd ldap@' /etc/nsswitch.conf \
 && sed -i 's@group:       sss files systemd@group:       sss files systemd ldap@' /etc/nsswitch.conf \
 && sed -i 's@shadow:     files sss@shadow:     files sss ldap@' /etc/nsswitch.conf

RUN echo $'pagesize 1000 \n\
referrals off \n\
idle_timelimit 800 \n\
filter passwd (Objectclass=user) \n\
map    passwd uid              sAMAccountName \n\
map    passwd uidNumber     objectSid:S-1-5-21-1391733952-3059161487-1245441232 \n\
map    passwd gidNumber     objectSid:S-1-5-21-1391733952-3059161487-1245441232 \n\
map    passwd homeDirectory    "/home/$sAMAccountName" \n\
map    passwd gecos            displayName \n\
map    passwd loginShell    "/bin/bash" \n\
filter shadow (Objectclass=user) \n\
map    shadow uid              sAMAccountName \n\
map    shadow shadowLastChange pwdLastSet \n\
filter group  (objectClass=group)' >> /etc/nslcd.conf

RUN echo $'auth        required      pam_env.so \n\
auth        sufficient    pam_unix.so try_first_pass nullok \n\
auth        sufficient    pam_ldap.so minimum_uid=1000 use_first_pass \n\
auth        required      pam_deny.so \n\
\n\
account     sufficient    pam_ldap.so minimum_uid=1000 \n\
account     required      pam_unix.so \n\
\n\
password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type= \n\
password    sufficient    pam_ldap.so minimum_uid=1000 try_first_pass \n\
password    sufficient    pam_unix.so try_first_pass use_authtok nullok sha512 shadow \n\
password    required      pam_deny.so \n\
\n\
session     optional      pam_ldap.so minimum_uid=1000 \n\
session     optional      pam_keyinit.so revoke \n\
session     required      pam_limits.so \n\
-session     optional      pam_systemd.so \n\
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid \n\
session     required      pam_unix.so' > /etc/pam.d/password-auth

RUN rm -f /run/nologin \
 && ssh-keygen -A

COPY entrypoint.sh /

CMD ["/entrypoint.sh"]