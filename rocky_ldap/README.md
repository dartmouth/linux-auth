## rocky-pam_ldap

Prerequisites
- A read-only service account (add LDAP_BIND_DN and LDAP_BIND_PASSWORD to secrets.sh)

docker run --rm -p 2222:22 -it rockylinux:8.7 bash

useradd d92495j
#useradd -rm -d /home/d92495j -s /bin/bash -g root -G sudo -u 1001 d92495j \

useradd -rm -d /home/local_user -s /bin/bash -g root -G sudo -u 1000 local_user \
echo 'local_user:p4ssw0rd' | chpasswd

```sh
# Load secrets into environment
source secrets.sh

# Enter this directory
cd rocky-pam_ldap

# Build container
docker build -t rocky-pam_ldap .

# Run a container
docker rm -f rocky-pam_ldap
docker run -d \
  --name rocky-pam_ldap \
  -e LDAP_BASE_DN="DC=kiewit,DC=dartmouth,DC=edu" \
  -e LDAP_BIND_DN="CN=InfraStaff01,OU=People,DC=kiewit,DC=dartmouth,DC=edu" \
  -e LDAP_BIND_PASSWORD="$LDAP_BIND_PASSWORD" \
  -e LDAP_URI="ldaps://onpremdc.kiewit.dartmouth.edu" \
  -p 2222:22 \
  rocky-pam_ldap
docker logs -f rocky-pam_ldap

# Test SSH with local user
ssh -p 2222 local_user@localhost
ssh -p 2222 d92495j@localhost
```