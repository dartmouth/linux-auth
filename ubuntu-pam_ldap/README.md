## ubuntu-pam_ldap

Prerequisites
- A read-only service account (add LDAP_BIND_DN and LDAP_BIND_PASSWORD to secrets.sh)

```sh
# Load secrets into environment
source secrets.sh

# Enter this directory
cd ubuntu-pam_ldap

# Build container
docker build -t ubuntu-pam_ldap .

# Run a container
docker rm -f ubuntu-pam_ldap
docker run -d \
  --name ubuntu-pam_ldap \
  -e LDAP_BIND_DN="$LDAP_BIND_DN" \
  -e LDAP_BIND_PASSWORD="$LDAP_BIND_PASSWORD" \
  -e LDAP_URI="ldaps://duoauthproxy.dartmouth.edu" \
  -p 2222:22 \
  ubuntu-pam_ldap
docker logs -f ubuntu-pam_ldap

# Test SSH with local user
ssh -p 2222 local_user@localhost
ssh -p 2222 d92495j@localhost
```