Player/Stage Install Script
=========================== 

A couple of bash scripts / a Vagrantfile to automate the installation process of Player 3 and Stage 4 for Ubuntu.

### What's New

This is a fork of the original Player/Stage Install Script at [samueljackson92/player-stage-install-script](https://github.com/samueljackson92/player-stage-install-script). It contains the following changes:

* **Player 3.0.2** and **Stage 4.1.1** are used
* A `Vagrantfile` has been added to simplify installation in a Ubuntu-based virtual machine using [**Vagrant**](https://www.vagrantup.com/).
* The install script now uses git and subversion to pull the sources instead of using wget if these tools are installed. This should counteract SourceForge's wonky download behavior.

## Installing via vagrant (recommended)

In order to quickly set up the Player/Stage installation, simply execute

```bash
$ vagrant up
```

To connect to the virtual machine, type

```bash
$ vagrant ssh
```

To shut down the virtual machine (without deleting it), type

```bash
$ vagrant halt
```

More information on how to use Vagrant can be found at the *Getting Started* tutorial on [www.vagrantup.com](https://www.vagrantup.com/).

## Manual Installation

These scripts
will automatically update bashrc with correct paths as well as downloading, compiling and installing Player and Stage from
source. The script effectively automates the commands outlined in the following two guides:

* [Upgrading to Ubuntu 11.10 with player/stage](http://yorkroboticist.blogspot.co.uk/2011/12/upgrading-to-ubuntu-1110-with.html)
* [Installing Player/Stage in Ubuntu (Natty Narwhal)](http://yorkroboticist.blogspot.co.uk/2011/10/installing-playerstage-in-ubuntu-natty.html)

This script should work with Ubuntu from 11.04+. I've tested it on a fresh install of Ubuntu 12.04 64 bit in a VM
and it seems to work fine. I'm unsure if it will work with versions of Ubuntu below 11.04.

#### Update
The script has now been patched to fix a minor compliation bug with Ubuntu 12.10.

### Pre-Install

Before installing Player/Stage, ensure that all other versions of Player/Stage have been removed from the machine.
If compiled from source this can be done by entering into the directory where Player or Stage was built and running:

```bash
$ sudo make uninstall
```

Also check that any old files relating to Player or Stage have been removed from both ```/usr/local/lib``` and ```/usr/local/lib64``` in
case this mucks with the paths. Finally, make sure that any path varaibles relating to Player/Stage are removed from the bashrc.

### Installing Player/Stage

First, either clone the git repo or download a tarball/zip file containing the files and extract them. Then ```cd``` into the
directory. Change the two scripts to have executable permissions using the following command:

```bash
$ chmod +x update-bashrc.sh player-stage-install.sh
```

Next, run update-bashrc.sh. This adds the path variables stored in path.txt to the bashrc. It's important to do this
so that Player/Stage can find each other correctly.

```bash
$ ./update-bashrc.sh
```

Finally, run the player-stage-install.sh script to download, compile and install Player/Stage. The script should
get all of the required dependancies if they are not already installed on the system. It will then create a folder called
src in the home directory where Player/Stage will be downloaded, complied and installed to the system. Run it with the
following.

```bash
$ ./player-stage-install.sh
```
If all works as intended, Player/Stage should then be correctly setup for use with CS264's assignment files.


