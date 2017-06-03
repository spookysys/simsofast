# Set up /mnt/share
source fileclient.sh

# Basics
sudo apt-get update -q
sudo apt-get install -qy nano htop less locate xauth ca-certificates curl wget bzip2 curl unzip


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


# Python
echo export PATH=/opt/conda/bin:\$PATH | sudo tee -a /etc/profile.d/conda.sh
echo export PATH=/opt/conda/bin:\$PATH >> ~/.bashrc
export PATH=/opt/conda/bin:$PATH
sudo apt-get install -qy libglib2.0-0 libxext6 libsm6 libxrender1
wget -q https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
sudo bash miniconda.sh -b -p /opt/conda
rm miniconda.sh


# locate.db
sudo updatedb
