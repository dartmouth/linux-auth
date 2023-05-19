# Linux Auth

The purpose of this repository is to document examples of how to secure Linux servers.

## Examples

List
- [rocky-pam_ldap](rocky-pam_ldap)
- [rocky-sssd](rocky-sssd)
- [rocky-sssd-domain_joined](rocky-sssd-domain_joined)
- [ubuntu-pam_ldap](ubuntu-pam_ldap)
- [ubuntu-pam_ldap](ubuntu-pam_ldap-duo)
- [ubuntu-sssd](ubuntu-sssd)
- [ubuntu-sssd-domain_joined](ubuntu-sssd-domain_joined)

## One time setup

Create a `secrets.sh` configuration file. This file will be ignored by git so you do not have to worry about it accidently being commited to this code respository. Here is an example of the file. See individual configurations to learn with environment variables are needed for each example.

```sh
export LDAP_BIND_DN='CN=SERVICE_ACCOUNT,OU=People,DC=kiewit,DC=dartmouth,DC=edu'
export LDAP_BIND_PASSWORD='REMOVED1'
```

## Misc

The following is a helpful command to use to remove the entries in ~/.ssh/known_hosts

```sh
ssh-keygen -R '[localhost]:2222'
```
