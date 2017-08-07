
# Good libs
conda install -qy -c dlr-sc pythonocc-core
pip install -q --no-cache-dir CoolProp
pip install -q --no-cache-dir openmdao
apt-get install -qqy gmsh
pip install -q --no-cache-dir pygmsh

# Python wrappers
pip install -q --no-cache-dir \
	meshio \
	pygmsh \
	pycalculix \
	fipy \
	openmdao
