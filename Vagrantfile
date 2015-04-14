$compose_install = <<SCRIPT
wget -q https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/trusty64"
    master.vm.hostname = "master"
    
    master.vm.provider "virtualbox" do |vb|
      vb.memory = 3072
      # configure the network
      master.vm.network :private_network, :ip => '10.0.0.2'
      master.vm.network "forwarded_port", guest:8080, host:8080
      master.vm.network "forwarded_port", guest:8888, host:8888
      master.vm.network "forwarded_port", guest:7077, host:7077
      master.vm.provision :hosts
    end
    master.vm.provision "docker" do |d|
      d.build_image "/vagrant/images/spark/base",   args: "-t beauzeaux/spark-base"
      d.build_image "/vagrant/images/spark/master", args: "-t beauzeaux/spark-master"
      d.build_image "/vagrant/images/spark/worker", args: "-t beauzeaux/spark-worker"
      d.build_image "/vagrant/images/notebook", args: "-t beauzeaux/notebook"
    end
    master.vm.provision "shell", inline: $compose_install
    master.vm.provision "shell", inline: "cd /vagrant/compose/master/ && docker-compose up -d"
  end

  config.vm.define "analysis-worker" do |analysis|
    analysis.vm.box = "ubuntu/trusty64"
    analysis.vm.hostname = "analysis-1"

    analysis.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      analysis.vm.network :private_network, :ip => '10.0.0.3'
      analysis.vm.provision :hosts
    end
    analysis.vm.provision "docker" do |d|
      d.build_image "/vagrant/images/spark/base", args: "-t beauzeaux/spark-base"
      d.build_image "/vagrant/images/spark/worker", args: "-t beauzeaux/spark-worker"
    end
    analysis.vm.provision "shell", inline: $compose_install
    # the following will need to be run manually for the time being
    # analysis.vm.provision "shell", inline: "cd /vagrant/compose/analysis-worker/ && docker-compose up -d"
  end
end
