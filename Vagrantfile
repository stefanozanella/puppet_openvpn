# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos-base-oss"
  config.vm.box_url = "http://vagrantboxes.derecom.it/boxes/centos-base-oss.box"
  config.vm.provision :puppet do |puppet|
    puppet.module_path = ".modules"
    puppet.manifests_path = "tests"
    puppet.manifest_file  = "init.pp"
  end
end
