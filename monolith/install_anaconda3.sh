# Install anaconda3

# apt-get dependencies
apt-get update -qq --fix-missing
apt-get install -qqy --no-install-recommends \
    libglib2.0-0 libxext6 libsm6 libxrender1

# apt-get cleanup
apt-get purge --auto-remove -qqy
rm -rf /var/lib/apt/lists/*

# Install Anaconda3
wget -q https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh -O anaconda3.sh
bash anaconda3.sh -b
rm anaconda3.sh

