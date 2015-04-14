Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|  
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

  config.vm.network "forwarded_port", guest:8083, host:8083

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "docker" do |d|
    d.build_image "/vagrant/", args: "-t=notebook"
  end
  config.vm.provision "docker" do |d|
    d.run "notebook", args:"-p 8083:8888 -e 'PASSWORD=password'"
  end
end
