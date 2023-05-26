## ubuntu_ldap

Prerequisites
- A read-only service account for LDAP authentication
- A DUO UNIX Application integration

```sh
# Enter this directory and load the environment
cd ubuntu_ldap
source ../set_env.sh

# Build container
docker build -t ubuntu_ldap .

# Run a container
docker rm -f ubuntu_ldap
docker run -d \
  --name ubuntu_ldap \
  -e LDAP_BIND_DN="$LDAP_BIND_DN" \
  -e LDAP_BIND_PASSWORD="$LDAP_BIND_PASSWORD" \
  -e LDAP_URI="$LDAP_URI" \
  -e LDAP_BASE="$LDAP_BASE" \
  -e DUO_INTEGRATION_KEY="$DUO_INTEGRATION_KEY" \
  -e DUO_SECRET_KEY="$DUO_SECRET_KEY" \
  -e DUO_HOST="$DUO_HOST" \
  -p 2222:22 \
  ubuntu_ldap
docker logs -f ubuntu_ldap
```

## Test

Create a netid account inside the container

```sh
NETID=d92495j
cat <<EOF | docker exec --interactive ubuntu_ldap sh
luseradd -d /home/$NETID -s /bin/bash -g root -u 1001 $NETID
usermod $NETID -a -G sudo,ldap_users
EOF
```

Test with the local_user and netid accounts

```sh
ssh -p 2222 local_user@localhost
ssh -p 2222 d92495j@localhost
```

## References

- https://duo.com/docs/duounix
