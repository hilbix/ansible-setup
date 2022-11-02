# Ansible Setup

## Usage

What you need to do first

- Create a VM
  - Name: `ansible`
- Install Debian 11 into it from scratch
  - give it a root-password
  - give it a user
  - give it a user-password
- After install:
  - start the machine
- find out the IP of the machine
  - in this example it is 192.168.1.2

Then

	git clone https://github.com/hilbix/ansible-install.git
	cd ansible-install
	make
	# enter user (if it is not the same as your running user)
	# enter user-password (asked by ssh-copy-id)
	# enter root-password (asked only once)

If you change something in the config, just type `make` again.

- However, you should really do it with a PlayBook using Semaphore.


## What this does

It initializes the machine fully with an Ansible and Semaphore stack from scratch.

Afterwards you only need to configure Semaphore using the browser and you are set up.

Just call <http://192.168.1.2/>


## FAQ

Why not use existing `Docker` containers?

- WTF?
- Do you really want to use someting, others are in control of?
- For the most curcial thing which exists, the basic install system?
- Really?

Why not use a dockerfile?

- I want a VM to be setup from scratch.

Why not install the VM, too?

- Had no time to do so with virsh-commands.
  - Hence this still is (the only) manual task

No `nano`?

- Sorry, my fingers do not speak `nano`.  They only speak `vim` and `emacs`.
- To allow all to fallback to `vim` needs a purge of `nano`
  - I really have no idea how to make `vim` the default without purging `nano`.

