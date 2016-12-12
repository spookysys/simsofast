
if [ -z "$RUN_REGRESSION" ]; then
    echo Regression tests disabled
fi 

if [ -z "$RUN_REGRESSION" ]; then true; else
    echo Regression tests enabled
fi 


apt-get update -qq --fix-missing 
apt-get install -qqy --no-install-recommends \
    automake build-essential \
    bsdtar swig \
    openmpi-bin libopenmpi1.6 \
    libopenmpi-dev \
    libopenblas-base liblapack3gf liblapacke \
    liblapack-dev liblapacke-dev libopenblas-dev \
    python-dev ssh 
wget -q https://bootstrap.pypa.io/get-pip.py 
python get-pip.py --no-wheel 
pip install -q numpy scipy mpi4py 
wget -qO- https://github.com/su2code/SU2/archive/v4.3.0.zip | bsdtar -xvf-mv SU2* SU2 
mkdir -p $SU2_HOME 
cp -R SU2/* $SU2_HOME 
cd /tmp/SU2 
sed -ri -e 's|(PYTHON_INCLUDE\s=\s).*|\1-I/usr/include/python2.7|g' SU2_PY/pySU2/Makefile.* 
sed -ri -e 's|(NUMPY_INCLUDE\s=\s).*|\1/usr/local/lib/python2.7/dist-packages/numpy/core/include|g' SU2_PY/pySU2/Makefile.* 
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
apt-get remove -qqy \
    automake build-essential \
    bsdtar swig \
    liblapack-dev liblapacke-dev libopenblas-dev \
    libopenmpi-dev 
apt-get autoremove -qqy 
apt-get purge -qy 
rm -rf /var/lib/apt/lists/* 
if [ -z "$RUN_REGRESSION" ]; then true; else  
    cd /tmp
    wget -qO- https://github.com/su2code/TestCases/archive/v4.3.0.zip | bsdtar -xvf-mv TestCases* TestCases
    cp -R /tmp/TestCases/* /tmp/SU2/TestCases 
    cd /tmp/SU2/TestCases
    python parallel_regression.py 
fi 
rm -rf /tmp/*


 
# RUN sed -ri -e "s|^import SU2|import SU2, multiprocessing|g" SU2_PY/parallel*.py 
# sed -ri -e "s|(dest=\"partitions\",\s*default=)2\b|\1multiprocessing\.cpu_count\(\)|g" SU2_PY/parallel*.py 
# make check 
# make install
 
# miniconda2: (ditched because too hard to get python and mpi to cooperate
#sed -ri -e 's|(PYTHON_INCLUDE\s=\s).*|\1-I/opt/conda/include/python2.7|g' SU2_PY/pySU2/Makefile.* 
#sed -ri -e 's|(NUMPY_INCLUDE\s=\s).*|\1/opt/conda/lib/python2.7/site-packages/numpy/core/include|g' SU2_PY/pySU2/Makefile.* \
