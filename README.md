> **NOT COMPLETELY READY YET**
>
> This does not install Semaphore yet (mainly because there is no native Debian package yet)
>
> However, Ansible already is usable.
>
> And Semaphore will follow (as a `git` checkout) as soon as I got it verified at my side.


# Ansible Setup

Bootstrap of a server or VM to provide Ansible and Semaphore from scratch.


## Rationale

In Disaster Recovery things must start somewhere.

- First, you must get on hold of the needed information
  - This is beyond the scope of this document
- Second, you need to reimplement your physical and logical infrastructure
  - This is beyond the scope of this document
  - This is, you buy bare metal and put it into work
  - However in the scope of this document, we use a cloud provider, something which is just there.
- Third, you need to create the network and interconnectivity
  - This is beyond the scope of this document
  - Without functionality
  - But every host has some basic OS installed and got it's IP and network connections
  - However in the scope of this document, we use a cloud provider, so the VMs are up and running
- Fourth, you need to setup everything
  - **This repository here is the first part on this task**
  - The next part would be to adapt all the configuration to your new infrastructure
  - And then you will - automatically - setup all your infrastructure back into the state before the disaster
  - And if you have done everything correctly before the disaster struck, your Infrastructure is back up running.
- Fifth, you need to restore all databases, file contents and so on
  - This is beyond the scope of this document
- Sixth, you grant all the (new) access rights to the people who are now involved
  - This is beyond the scope of this document

Then you are back in operation.

The first thing in the fifth step is to get your deployment system up and running.
This is exactly what this here does:

- Before you have a minimal installed up and running VM
- Afterwards you have this VM set up such, that Ansible is able to bring back functionality to your infrastructure.

It may not seem to be a big deal.  Installing Ansible yourself is easy.  Right.

But there is a bit of a difference if this is manually done or automated.

With automation, you can test the procedure if it really works and there is no lack of documentation.
Something which, perhaps, is puzzling, because this step involves some knowledge, which is no more there after disaster struck.

So you need some bootstrapping of your confuguration management.

And this is exactly, what this repository does.  It bootstraps Ansible.

Not from scratch, but from your OS vendor: Debian


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
  - It is only used to bootstrap


## Usage

	git clone https://github.com/hilbix/ansible-install.git
	cd ansible-install
	make

This will prompt for following details if needed:

- The non-root user's password
- The root password

This is idempotent, so does no harm if you run it again.
And if the machine already is setup, it will not prompt for anything.


## Then

> This task is not ready yet!

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

