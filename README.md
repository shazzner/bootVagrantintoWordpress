# bootVagrantintoWordpress
A simple script that creates a vagrant box with wordpress ready to go

## About
Doing web development might require having several separate instances of Wordpress going on your development machine. This script will spin up a Vagrant box and setup wordpress.

It will launch the site on localhost on port 8080. Future versions might set a specific IP and add a domain name to your hosts file.

At the moment it won't run through the install script automatically so you still have to go to http://localhost:8080/wp-admin/install.php to finialize the steps.

## Requirements
Tested on:

1. Ubuntu 15.04 x64, but should work on newer versions.
2. Linux Mint 17.3 Cinnamon 64-bit

You'll need VirtualBox, Vagrant, ChefDK, and Vagrant-berkshef in order to run the script successfully:

1. Install VirtualBox and it's kernel extensions, the packaged version seems to work fine

        $ sudo apt-get install virtualbox virtualbox-dkms

2. Install the latest version of [Vagrant](http://www.vagrantup.com/downloads.html)
3. Install the latest version of [ChefDK](https://downloads.chef.io/chef-dk/)
4. Install the Vagrant Berkshelf plugin:

        $ vagrant plugin install vagrant-berkshelf

You'll also need a folder called 'cookbooks' in your development folder, along with the latest git version of the [wordpress recipe](https://github.com/brint/wordpress-cookbook).

## Installation

Copy the bootVagrant.sh script into your development folder, make it executable:

         $ chmod +x bootVagrant.sh

## Usage

Run the script and with the name of your folder/project-name:

        $ ./bootVagrant.sh newSite

## License and Author

Copyright (c) 2016 Chris Hardee
- Chris Hardee (shazzner@gmail.com)

License under the GPLv3, see LICENSE for details
