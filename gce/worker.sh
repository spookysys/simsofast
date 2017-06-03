#!/bin/bash

# Dependencies
sudo apt-get update -q
sudo apt-get install -qy \
	nano htop less locate xauth \
	ca-certificates curl wget bzip2 unzip curl

# Mount shared disk
sudo apt-get install -qy sshfs nfs-common autofs
sudo mkdir /mnt/shared
sudo chmod a+rwx /mnt/shared
echo fileserver:/mnt/shared /mnt/shared nfs rw 0 0 | sudo tee -a /etc/fstab
echo /- /etc/auto.mount | sudo tee -a /etc/auto.master
echo "/mnt/shared -fstype=nfs,rw fileserver:/mnt/shared" | sudo tee -a /etc/auto.mount
systemctl restart autofs

# Docker
sudo apt-get install -qy \
	apt-transport-https ca-certificates software-properties-common
curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
sudo add-apt-repository \
	"deb https://apt.dockerproject.org/repo/ \
	debian-$(lsb_release -cs) \
	main"
sudo apt-get update -q
sudo apt-get -qy install docker-engine
sudo docker run hello-world

# Pull some containers
sudo docker pull simsofast/pyt3
sudo docker pull simsofast/su2
# sudo docker run -itd --rm -v /mnt/shared:/mnt/shared --name pyt3 simsofast/pyt3
# sudo docker run -itd --rm -v /mnt/shared:/mnt/shared --name su2 simsofast/su2

# Misc
sudo updatedb
