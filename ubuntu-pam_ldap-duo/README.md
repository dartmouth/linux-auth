## ubuntu-pam_ldap-duo

Prerequisites
- A read-only service account
- Add LDAP_BIND_PASSWORD, DUO_INTEGRATION_KEY, and DUO_SECRET_KEY to secrets.sh

```sh
# Load secrets into environment
source secrets.sh

# Enter this directory
cd ubuntu-pam_ldap-duo

# Build container
docker build -t ubuntu-pam_ldap-duo .

# Run a container
docker rm -f ubuntu-pam_ldap-duo
docker run -d \
  --name ubuntu-pam_ldap-duo \
  -e LDAP_BIND_DN="CN=InfraStaff01,OU=People,DC=kiewit,DC=dartmouth,DC=edu" \
  -e LDAP_BIND_PASSWORD="$LDAP_BIND_PASSWORD" \
  -e LDAP_URI="ldaps://onpremdc.kiewit.dartmouth.edu" \
  -e DUO_INTEGRATION_KEY="$DUO_INTEGRATION_KEY" \
  -e DUO_SECRET_KEY="$DUO_SECRET_KEY" \
  -e DUO_HOST="api-426aaf62.duosecurity.com" \
  -p 2222:22 \
  ubuntu-pam_ldap-duo
docker logs -f ubuntu-pam_ldap-duo

# Test SSH with local user
ssh -p 2222 local_user@localhost
ssh -p 2222 d92495j@localhost
```