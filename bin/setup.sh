#!/bin/bash


STDOUT() { local e=$?; printf '%q' "$1"; [ 1 -ge $# ] || printf ' %q' "${@:2}"; printf '\n'; return $e; }
STDERR() { local e=$?; STDOUT "$@" >&2; return $e; }
OOPS() { STDERR OOPS: "$@"; exit 23; }
x() { "$@"; }
o() { x "$@" || OOPS fail $?: "$@"; }

stamp()
{
  printf '%(%Y%m%d-%H%M%S)T\n'
}

# Wait for the host
o ansible-playbook -i inventory/ansible playbooks/wait.yml

# Transfer our SSH credentials
o ssh-copy-id ansible

# Setup sudo
# Do it a way which also works for older local ansible variants
x ssh ansible sudo true || o ansible-playbook -i inventory/ansible playbooks/sudo.yml -K

# Install ansible
# We need to do this here, because our local ansible may be too old
o ansible-playbook -i inventory/ansible playbooks/ansible.yml

# Create or update copy of this installation
x ssh ansible git init git/ansible-setup
o git push ansible:git/ansible-setup/.git HEAD:setup-branch
o ssh ansible 'cd git/ansible-setup && git checkout -f master setup-branch'

# Install all other recommended packages
o ansible-playbook -i inventory/ansible playbooks/packages.yml

# Install and setup semaphore
o ansible-playbook -i inventory/ansible playbooks/semaphore.yml

