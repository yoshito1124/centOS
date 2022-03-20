# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook       = "playbook/setup.yml"
    ansible.version        = "latest"
    ansible.install        = true
  end
end
