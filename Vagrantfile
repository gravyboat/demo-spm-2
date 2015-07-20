# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))

OS = {
  box: 'centos-min',
  virtualbox: 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box',
  vmware_fusion: 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-fusion503-nocm.box'
}

Vagrant.configure('2') do |config|
  config.vm.box_url  = OS[:virtual_box]
  config.vm.box      = OS[:box]
  config.vm.hostname = "demo-spm-2"

  config.vm.provider(:virtualbox) do |vb|
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    vb.memory = 2048
    vb.cpus = 2
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.ssh.forward_agent = true

  config.vm.synced_folder('salt/roots/salt', '/srv/salt/demo-spm-2')
  config.vm.synced_folder('salt/pillar_data', '/srv/pillar')

  config.vm.provision "shell", inline: "sudo yum update -y nss\*"

  config.vm.define "demo-spm-2_0" do |node|
    node.vm.network 'private_network', ip: '192.168.44.2'
    node.vm.synced_folder './', '/home/vagrant/demo-spm-2'

    node.vm.provision(:salt) do |s|
      s.install_type = "git"
      s.install_args = "v2015.8.0rc1"
      s.verbose       = true
      s.minion_config = 'salt/minion/demo_spm_2'
      s.run_highstate = true
    end
  end

end
