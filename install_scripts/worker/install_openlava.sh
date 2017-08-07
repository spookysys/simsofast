

sudo apt-get install -qqy ncurses-dev tcl-dev

wget -q http://www.openlava.org/tarball/openlava-2.2.tar.gz
tar xvf openlava*
cd openlava*
./configure
make -j `nproc` 
make check 
sudo make install 
