# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty32"

  # suppressing "stdin: is not a tty" error
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision "shell", inline: <<-SHELL
    # enables backports repositories
    sed -i '/^#\+\s*deb\(-src\)\?\s\+.*-backports/s/^#\+\s*//' /etc/apt/sources.list

    # update and upgrade
    apt-get -y update
    apt-get -y upgrade

    # git and subversion
    apt-get -y install git subversion

    VAGRANT_HOME=`pwd`

    # clone and execute the player/stage install script
    rm -rf $VAGRANT_HOME/player-stage-install-script
    git clone --depth 1 https://github.com/sunsided/player-stage-install-script.git $VAGRANT_HOME/player-stage-install-script
    cd $VAGRANT_HOME/player-stage-install-script
    
    # use non-interactive mode for apt-get
    sed -i 's/^sudo apt-get install/sudo apt-get -y install/g' player-stage-install.sh

    # update-bash.sh is not used in this automated setup
    # we do it manually instead
    chmod -x update-bashrc.sh
    # ./update-bashrc.sh
    cat paths.txt >> $VAGRANT_HOME/.bashrc

    # executing the install script
    chmod +x player-stage-install.sh
    ./player-stage-install.sh

    # hand everything over to the vagrant user
    chown -R vagrant:vagrant .

  SHELL
end
