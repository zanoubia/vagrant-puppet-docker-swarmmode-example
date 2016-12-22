# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.boot_timeout=1500
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "10.0.2.15"  
  config.vm.hostname = "dhost1"

  config.vm.provision "shell", path: "provision.sh"

  config.vm.provision "docker" do |d|
    #d.build_image "/vagrant", args:  "-t guestbook:1.0"
    #d.pull_images "redis"
    #d.pull_images "nginx"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.options = "--verbose --debug --hiera_config=/tmp/vagrant-puppet/environments/production/hiera.yaml"
    puppet.environment_path = "environments"
    puppet.environment = "production"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.working_directory = "/tmp/vagrant-puppet"
    puppet.facter = {
      "swarm_role" => "manager"
    }
  end


end
