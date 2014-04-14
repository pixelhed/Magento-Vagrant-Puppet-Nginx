# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #config.vm.host_name = "foo"
  config.vm.box = "hashicorp/precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.hostname = "magento.dev"

  # configure virtualbox provider 
  config.vm.provider "virtualbox" do |vb|
    # increase memory
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.vm.network "private_network", ip: "192.168.14.40"

  config.vm.synced_folder "data", "/vagrant_data", type:"nfs"

  config.vm.provision :shell, :inline => "sudo apt-get update && sudo apt-get install puppet -y"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "base.pp"
     puppet.module_path    = "puppet/modules"
     puppet.options        = "--verbose --debug"
  end
end
