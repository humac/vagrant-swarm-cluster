$setup_docker = <<SCRIPT
apt-get -y update && apt-get -y upgrade;
DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -;
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get install -y docker-ce docker-ce-cli containerd.io;
sed -i 's|-H fd://|-H fd:// -H tcp://0.0.0.0:2375|g' /lib/systemd/system/docker.service;
systemctl daemon-reload && systemctl restart docker.service;
add-apt-repository ppa:gluster/glusterfs-7 && apt-get update; 
apt-get install -y glusterfs-server;
echo "10.20.30.201    swarmnode1      gluster1" >> /etc/hosts;
echo "10.20.30.202    swarmnode2      gluster2" >> /etc/hosts;
echo "10.20.30.203    swarmnode3      gluster3" >> /etc/hosts;
apt-get -y update && apt-get -y upgrade;
systemctl enable glusterd; 
systemctl start glusterd;
systemctl status glusterd;
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.define "swarmnode1" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "swarmnode1"
    # Specify the interface when creating the public network
    config.vm.network "public_network", bridge: "en1: Wi-Fi (AirPort)", ip: "10.20.30.201"
    config.vm.provision "shell", inline: $setup_docker
  end

  config.vm.define "swarmnode2" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "swarmnode2"
    # Specify the interface when creating the public network
    config.vm.network "public_network", bridge: "en1: Wi-Fi (AirPort)", ip: "10.20.30.202"
    config.vm.provision "shell", inline: $setup_docker
  end

  config.vm.define "swarmnode3" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "swarmnode3"
    # Specify the interface when creating the public network
    config.vm.network "public_network", bridge: "en1: Wi-Fi (AirPort)", ip: "10.20.30.203"
    config.vm.provision "shell", inline: $setup_docker
  end
end
