Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/bionic64'

  config.vm.provision 'deps', type: :shell, inline: <<-SHELL
    set -e
    sudo apt-get update
    sudo apt-get install -y \
      ctags \
      inotify-tools \
      build-essential \
      ruby ruby-dev \
      git \
      shellcheck
    gem install -N bundler
  SHELL

  config.vm.provision 'hub', type: :shell, inline: <<-SHELL
    set -e
    curl -sL https://github.com/github/hub/releases/download/v2.4.0/hub-linux-amd64-2.4.0.tgz \
      -o hub-linux-amd64-2.4.0.tgz
    tar xzf hub-linux-amd64-2.4.0.tgz
    cd hub-linux-amd64-2.4.0
    sudo ./install
  SHELL
end
