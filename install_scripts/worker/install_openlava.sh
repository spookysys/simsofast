# TODO: Change to PBS Professional

sudo apt-get install -qqy ncurses-dev tcl-dev

wget -q http://www.openlava.org/tarball/openlava-2.2.tar.gz
tar xvf openlava*
cd openlava*

# http://www.openlava.org/documentation/quickstart.html
./configure
make -j `nproc` 
make check 
sudo make install 

cd config
sudo cp lsb.hosts lsb.params lsb.queues lsb.users \
    lsf.cluster.openlava lsf.conf lsf.shared lsf.task openlava.* \
    /opt/openlava-2.2/etc
cd ..

sudo useradd -r openlava

sudo chown -R openlava:openlava /opt/openlava-2.2
sudo cp /opt/openlava-2.2/etc/openlava /etc/init.d
sudo cp /opt/openlava-2.2/etc/openlava.* /etc/profile.d
#sudo chkconfig openlava on

cd /opt/openlava-2.2/etc
sudo nano lsf.cluster.openlava

