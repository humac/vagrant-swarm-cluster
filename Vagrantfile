$setup_docker = <<SCRIPT
apt-get update;
DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -;
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update;
apt-get install -y docker-ce docker-ce-cli containerd.io;

sed -i 's|-H fd://|-H fd:// -H tcp://0.0.0.0:2375|g' /lib/systemd/system/docker.service;
systemctl daemon-reload && systemctl restart docker.service;
echo "10.20.30.201    swarmnode1      gluster1" >> /etc/hosts;
echo "10.20.30.202    swarmnode2      gluster2" >> /etc/hosts;
echo "10.20.30.203    swarmnode3      gluster3" >> /etc/hosts;
# apt-get -y update && apt-get -y upgrade;
# apt-get install -y software-properties-common;
# add-apt-repository ppa:gluster/glusterfs-7 && apt-get update; 
# apt-get install -y glusterfs-server;
# systemctl enable glusterd; 
# systemctl start glusterd;
# systemctl status glusterd;
SCRIPT

disk = './secondDisk.vdi'
Vagrant.configure(2) do |config|
  config.vm.define "swarmnode1" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "swarmnode1"
    config.vm.network "public_network", ip: "10.20.30.201"
    config.vm.provider "virtualbox" do |vb|
      unless File.exist?(disk)
        vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 20 * 1024]
      end
      vb.memory = "2048"
      vb.customize ['storageattach', :id,  '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    end
    config.vm.provision "shell", inline: $setup_docker
  end

  config.vm.define "swarmnode2" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "swarmnode2"
    config.vm.network "public_network", ip: "10.20.30.202"
    config.vm.provider "virtualbox" do |vb|
      unless File.exist?(disk)
        vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 20 * 1024]
      end
      vb.memory = "2048"
      vb.customize ['storageattach', :id,  '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    end
    config.vm.provision "shell", inline: $setup_docker
  end

  config.vm.define "swarmnode3" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "swarmnode3"
    config.vm.network "public_network", ip: "10.20.30.203"
    config.vm.provider "virtualbox" do |vb|
      unless File.exist?(disk)
        vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 20 * 1024]
      end
      vb.memory = "2048"
      vb.customize ['storageattach', :id,  '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    end
    config.vm.provision "shell", inline: $setup_docker
  end
end
