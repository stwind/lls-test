# -*- mode: ruby -*-
# vi: set ft=ruby :

box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"

def provision(cfg)

  # https://github.com/mitchellh/vagrant/issues/1673
  cfg.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  cfg.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible/hosts/vagrant"
    ansible.playbook = "ansible/playbooks/site.yml"
    ansible.tags = ["mysql"]
    ansible.verbose = "v"
    ansible.raw_arguments = ["--extra-vars='init_user=vagrant'",
                             "--module-path=ansible/library"]
  end

end

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end

  config.vm.define "v01.vm" do |cfg|

    cfg.vm.hostname = "v01.vm"
    cfg.vm.box = "ubuntu"
    cfg.vm.box_url = box_url
    cfg.vm.network :private_network, :ip => "192.168.33.10"
    provision(cfg)

  end
end
