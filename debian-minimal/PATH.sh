export BASEDIR=/home/falbr_01/dune-gdt-pymor-interaction
export INSTALL_PREFIX=$BASEDIR/debian-minimal/local
export PATH=$INSTALL_PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$INSTALL_PREFIX/lib64:$INSTALL_PREFIX/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib64/pkgconfig:$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/share/pkgconfig:$PKG_CONFIG_PATH
export CC=gcc
export CXX=g++
export F77=gfortran
[ -e $INSTALL_PREFIX/bin/activate ] && . $INSTALL_PREFIX/bin/activate
export OMP_NUM_THREADS=1
