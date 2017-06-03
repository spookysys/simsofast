
sudo apt-get install -qy \
    libopenblas-base liblapack3gf liblapacke \
    openmpi-bin libopenmpi1.6


# BEGIN Install calculix
CALCULIX_VERSION=2.11

# Solver
wget -q http://www.dhondt.de/ccx_$CALCULIX_VERSION.tar.bz2 -O /usr/local/ccx.tar.bz2
cd /usr/local
tar xvf ccx.tar.bz2
mv CalculiX/ccx_*/src/ccx_* /usr/local/bin/ccx
rm ccx.tar.bz2
cd /tmp

# GUI 
wget -q http://www.dhondt.de/cgx_$CALCULIX_VERSION.bz2 -O /tmp/cgx.bz2
# (TODO..)

# END install calculix


# BEGIN install pyt3

# Install gmsh
sudo apt-get install -qy gmsh

# Create environment
conda create -qy --name pyt3 python=3 numpy scipy mpi4py matplotlib

# Activate environment
source activate pyt3

# Install conda packages from different channels
conda install -qy -c dlr-sc pythonocc-core

# Install pip packages
pip install -q --no-cache-dir \
	petsc4py meshio pygmsh \
	pycalculix fipy CoolProp \
	openmdao

# Deactivate pyt3
source deactivate

# END install pyt3


# BEGIN install SU2
echo export SU2_RUN=/usr/local/bin >> ~/.bashrc
echo export SU2_HOME=/opt/su2 >> ~/.bashrc
echo export PATH=\$PATH:\$SU2_RUN >> ~/.bashrc
echo export PYTHONPATH=\$PYTHONPATH:\$SU2_RUN >> ~/.bashrc
source ~/.bashrc

SU2_VERSION=5.0.0

if [ -z "$SU2_RUN_REGRESSION" ]; then 
    echo Regression tests disabled
else
    echo Regression tests enabled
fi

# Install dependencies
sudo apt-get install -qy \
    automake build-essential swig \
    liblapack-dev liblapacke-dev libopenblas-dev \
    libopenmpi-dev

# Download and untar
wget -q https://github.com/su2code/SU2/archive/v$SU2_VERSION.tar.gz
tar xvf v$SU2_VERSION.tar.gz
rm v$SU2_VERSION.tar.gz
mv SU2* SU2 

# Create and activate environment for SU2
conda create -qy --name su2 python=2.7 numpy scipy mpi4py
source activate su2
echo "CONDA_PREFIX: $CONDA_PREFIX"

# Configure and build SU2
mkdir -p $SU2_HOME 
cp -R SU2/* $SU2_HOME 
cd /tmp/SU2 
sed -ri -e 's|(PYTHON_INCLUDE\s=\s)|\1-I${CONDA_PREFIX}/include/python2.7 |g' SU2_PY/pySU2/Makefile.*
sed -ri -e 's|(NUMPY_INCLUDE\s=\s)|\1${CONDA_PREFIX}/lib/python2.7/site-packages/numpy/core/include -I|g' SU2_PY/pySU2/Makefile.*
sed -ri -e 's|(MPI4PY_INCLUDE\s=\s)|\1${CONDA_PREFIX}/lib/python2.7/site-packages/mpi4py/include -I|g' SU2_PY/pySU2/Makefile.*
sed -ri -e 's|(-lpython2.7)|\1 -L${CONDA_PREFIX}/lib|g' SU2_PY/pySU2/Makefile.*
sed -ri -e 's|(TECIO_LIB\s=).*|\1|g' SU2_PY/pySU2/Makefile.*
chmod ug+x configure preconfigure.py 
./configure \
    CXXFLAGS="-O2 -g" \
    --srcdir=$SU2_HOME \
    --enable-mpi --with-cc=/usr/bin/mpicc --with-cxx=/usr/bin/mpicxx \
    --with-LAPACK-lib=/usr/lib --with-LAPACK-include=/usr/include \
    --enable-PY_WRAPPER \
    --disable-tecio 
make -j `nproc` 
make check 
make install 

# Uninstall packages needed for build
sudo apt-get purge --auto-remove -qy \
    automake build-essential swig \
    liblapack-dev liblapacke-dev libopenblas-dev \
    libopenmpi-dev 

# Run regression
if [ -z "$SU2_RUN_REGRESSION" ]; then true; else  
    cd /tmp
    wget -q https://github.com/su2code/TestCases/archive/v$SU2_VERSION.tar.gz
    tar xvf v$SU2_VERSION.tar.gz
    rm v$SU2_VERSION.tar.gz
    mv TestCases* TestCases
    cp -R /tmp/TestCases/* /tmp/SU2/TestCases 
    cd /tmp/SU2/TestCases
    python parallel_regression.py 
    cd /tmp
    rm -r /tmp/TestCases
fi 

# Delete source code
rm -rf /tmp/SU2

# deactivate enviromnent
source deactivate


# Misc
sudo updatedb
