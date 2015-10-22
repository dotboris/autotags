Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision 'shell', inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y ctags inotify-tools build-essential libgmp-dev

    sudo gpg --keyserver hkp://keys.gnupg.net \
      --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io \
      | bash -s stable --ruby=2.2.3 --with-gems=bundler
    sudo gpasswd -a vagrant rvm
  SHELL
end
