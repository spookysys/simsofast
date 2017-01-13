#!/bin/bash

if [ -z "$RUN_REGRESSION" ]; then 
    echo Regression tests disabled
else
    echo Regression tests enabled
fi

# Install dependencies
apt-get update -qq --fix-missing 
apt-get install -qqy --no-install-recommends \
    automake build-essential \
    bsdtar swig \
    openmpi-bin libopenmpi1.6 \
    libopenmpi-dev \
    libopenblas-base liblapack3gf liblapacke \
    liblapack-dev liblapacke-dev libopenblas-dev \
    ssh python-dev

# Download and untar
wget -qO- https://github.com/su2code/SU2/archive/v4.3.0.zip | bsdtar -xvf- 
mv SU2* SU2 

# Create and activate environment for SU2
conda create -qqy --name su2 python=2.7 numpy scipy mpi4py
source activate su2

# Configure and build SU2
mkdir -p $SU2_HOME 
cp -R SU2/* $SU2_HOME 
cd /tmp/SU2 
sed -ri -e 's|(PYTHON_INCLUDE\s=\s).*|\1-I$CONDA_PREFIX/include/python2.7|g' SU2_PY/pySU2/Makefile.* 
sed -ri -e 's|(NUMPY_INCLUDE\s=\s).*|\1$CONDA_PREFIX/lib/python2.7/site-packages/numpy/core/include|g' SU2_PY/pySU2/Makefile.* 
sed -ri -e 's|(TECIO_LIB\s=).*|\1|g' SU2_PY/pySU2/Makefile.* 
chmod ug+x configure preconfigure.py 
./configure \
    CXXFLAGS="-O2 -g" \
    --enable-mpi --with-cc=/usr/bin/mpicc --with-cxx=/usr/bin/mpicxx \
    --with-LAPACK-lib=/usr/lib --with-LAPACK-include=/usr/include \
    --enable-PY_WRAPPER \
    --disable-tecio 
make -j `nproc` 
make check 
make install 

# Uninstall packages needed for build
apt-get apt-get purge --auto-remove -qqy \
    automake build-essential \
    bsdtar swig \
    liblapack-dev liblapacke-dev libopenblas-dev \
    libopenmpi-dev 

# Run regression
if [ -z "$RUN_REGRESSION" ]; then true; else  
    cd /tmp
    wget -qO- https://github.com/su2code/TestCases/archive/v4.3.0.zip | bsdtar -xvf-
    mv TestCases* TestCases
    cp -R /tmp/TestCases/* /tmp/SU2/TestCases 
    cd /tmp/SU2/TestCases
    python parallel_regression.py 
fi 

# Delete source code
rm -rf /tmp/SU2

# apt-get cleanup
apt-get purge --auto-remove -qqy
rm -rf /var/lib/apt/lists/*

# conda cleanup
conda clean -t

# deactivate enviromnent
source deactivate