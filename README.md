# Linux Auth

The purpose of this repository is to document examples of how to secure Linux servers.

## Examples

List
- [rocky_ldap](rocky_ldap)
- [ubuntu_ldap](ubuntu_ldap)

## One time setup

Create a `set_env.sh` configuration file. This file will be ignored by git so you do not have to worry about it accidently being commited to this code respository. Here is an example of the file. See individual configurations to learn which environment variables are needed for each example.

```sh
export LDAP_URI='ldaps://onpremdc.kiewit.dartmouth.edu'
export LDAP_BASE='dc=kiewit,dc=dartmouth,dc=edu'
export LDAP_BIND_DN='CN=SERVICE_ACCOUNT,OU=People,DC=kiewit,DC=dartmouth,DC=edu'
export LDAP_BIND_PASSWORD='REMOVED1'
export DUO_SECRET_KEY='X1hXztPX1rb1X71x1wXkpnmXXvqXXXqqj1XoXbbXu'
export DUO_INTEGRATION_KEY='DIXXXXXXXXXXXXXXXXXX'
export DUO_HOST='api-XXXXXXXX.duosecurity.com'
```

## Misc

The following is a helpful command to use to remove the entries in ~/.ssh/known_hosts

```sh
ssh-keygen -R '[localhost]:2222'
```
