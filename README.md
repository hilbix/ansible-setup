# Ansible Setup

Bootstrap of a server or VM to provide Ansible and Semaphore from scratch.


## Requirements

- Local is the local machine you work on
  - It is already running a recent Debian or Ubuntu (20.04 LTS is sufficient)
  - You have `root` access on Local
  - You can install new packages on Local
- Destination is the machine, Ansible and Semaphore shall be set up
  - It is a bare bone minimal Debian install
  - with the usual non-root user
  - You can login into Destinatian as the non-root user with `ssh ansible` and the user's password
  - `ssh root@ansible` does not work (yet)
  - You know the `root` password


## Preparation

On Local install `ansible`

- probably with `sudo apt install ansible make`
  - Perhaps this needs some more packages, I do not know, sorry.
- It does not need to be the newest version
  - It is only used to bootstrap more easily


## Usage

	git clone https://github.com/hilbix/ansible-install.git
	cd ansible-install
	make

This will prompt for following details if needed:

- The non-root user's password
- The root password

This is idempotent, so does no harm if you accidentally run it again.
And if the machine already is setup, it will not prompt for anything.


## Then

Open a browser to your Ansible host with `http` protocol.

If you want to setup `https` do it as follows:

- Use LetsEncrypt to deploy an `ssl` certificate to the machine
  - How to LetsEncrypt see <https://github.com/hilbix/dehydrated/wiki>
- The setup already prepared the user `letsencrypt`
  - Home is `/etc/letsencrypt/` but without `ssh`-credentials yet

> FYI: Here is how I get a Cert for internal domains.
>
> - One way would be to use DNS-01, but I currently do not support that at my side
> - The other way is to provide some external dummy-service for the domain name
>   and use another name resolution on the Intranet.  This is the way I go.
> - I really do not recommend to put the hosts like Ansible onto the public Internet.
>   - Such hosts must be defended at all costs, so no incoming connectivity, please!

To setup `ssh`-credentials on `/etc/letsencrypt` provide a file

	letsencrypt.pub

in the current directory and type:

	make

If you are happy with the letsencrypt setup type

	make https

This switches off `http` mode.


## FAQ

No `nano`?

- Sorry, my fingers do not speak `nano`.  They only speak `vim` and `emacs`.
- To allow all to fallback to `vim` needs a purge of `nano`
  - I really have no idea how to make `vim` the default without purging `nano`.

License?

- Free as free beer, free speech or free Baby.

