#!/bin/bash
# Install calculix

VERSION=2.11

# Solver
wget -q http://www.dhondt.de/ccx_$VERSION.tar.bz2 -O /usr/local/ccx.tar.bz2
cd /usr/local
tar xvf ccx.tar.bz2
mv CalculiX/ccx_*/src/ccx_* /usr/local/bin/ccx
rm ccx.tar.bz2
cd /tmp

# GUI 
# wget -q http://www.dhondt.de/cgx_$VERSION.bz2 -O /tmp/cgx.bz2

