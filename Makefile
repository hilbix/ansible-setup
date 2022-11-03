#

love:	all

all:
	st="`git status --porcelain`" && [ -z "$$st" ] || { echo 'git status not clean!'; echo "$$st"; exit 1; }

	# Wait for the host
	ansible-playbook -i inventory/ansible playbooks/wait.yml
	
	# Transfer our SSH credentials
	ssh-copy-id ansible
	
	# Setup sudo
	# Do it a way which also works for older local ansible variants
	ssh ansible sudo true || ansible-playbook -i inventory/ansible playbooks/sudo.yml -K
	
	# Install ansible
	# We need to do this here, because our local ansible may be too old
	ansible-playbook -i inventory/ansible playbooks/ansible.yml
	
	# Create or update copy of this installation
	-ssh ansible git init git/ansible-setup
	git push ansible:git/ansible-setup/.git HEAD:setup-branch
	ssh ansible 'cd git/ansible-setup && git checkout -B master setup-branch'
	
	# Install all other recommended packages
	ansible-playbook -i inventory/ansible playbooks/packages.yml
	
	# Install and setup semaphore
	ansible-playbook -i inventory/ansible playbooks/semaphore.yml

https:
	bin/https.sh

