```
# This file is part of the dune-gdt-pymor-interaction project:
#   https://github.com/dune-community/dune-gdt-pymor-interaction
# Copyright holders: Felix Schindler
# License: BSD 2-Clause License (http://opensource.org/licenses/BSD-2-Clause)
```

[dune-gdt-pymor-interaction](https://github.com/dune-community/dune-gdt-pymor-interaction)
is a git supermodule which serves as a demonstration for the interaction between
[dune-gdt](https://github.com/dune-community/dune-gdt) and [pymor](http://pymor.org).


Some notes on required software
===============================

* Compiler: we currently test gcc >= 4.9 and clang >= 3.8, other compilers may also work
* If you want to use alugrid (recommended) you need metis installed for DUNE to find alugrid (if your metis is
  installed somewhere else than `/usr/`, you need to adapt the metis location in the appropriate alugrid build command
  in `external-libraries.sh`).
* For a list of minimal (and optional) dependencies for several linux distributions, you can take a look at the
  [docker-for-dune](https://github.com/ftalbrecht/docker-for-dune) repository, e.g.,
  [debian/Dockerfile.minimal](https://github.com/ftalbrecht/docker-for-dune/blob/master/debian/Dockerfile.minimal)
  for the minimal requirements on Debian jessie (and derived distributions).


To build everything, do the following
=====================================


* Initialize all submodules:

  ```
  git submodule update --init --recursive
  ```
  
* Take a look at `config.opts/` and find settings and a compiler which suits your system, e.g. `config.opts/gcc`. The
  important part to look for is the definition of `CC` in these files: if, e.g., you wish to use clang in version 3.8
  and clang is available on your system as `clang-3.8`, choose `OPTS=clang-3.8`, if it is available as `clang`, choose
  `OPTS=clang`. Select one of those options by defining
  
  ```
  export OPTS=gcc
  ```

  If you have the `ninja` generator installed we recommend to make use of it by selecting `OPTS=gcc.ninja` (if such a
  file exists), which usually speeds up the builds.
  
* Call

  ```
  ./local/bin/gen_path.py
  ```
  
  to generate a file `PATH.sh` which defines a local build environment. From now on you should source this file
  whenever you plan to work on this project, e.g. (depending on your shell):
  
  ```
  source PATH.sh
  ```

* Download and build all external libraries by calling (this _might_ take some time):

  ```
  ./local/bin/download_external_libraries.py
  ./local/bin/build_external_libraries.py
  ```

  This will in particular create a small Python virtualenv for the jupyter notebook, the configuration of which can be
  adapted by editing the virtualenv section in `external-libraries.cfg` (see below). This virtualenv will be activated
  from now on, whenever `PATH.sh` is sourced again. If you do not wish to make use of the virtualenv, simply disable
  the respective section in `external-libraries.cfg`. Due to a bug in dune-python (regarding pyparsing), however, we
  currently require this virtualenv to build DUNE:

  ```
  source PATH.sh
  ```

* Build all DUNE modules using `cmake` and the selected options (this _will_ take some time):

  ```
  ./dune-common/bin/dunecontrol --opts=config.opts/$OPTS --builddir=$PWD/build-$OPTS all
  ```
  
  This creates a directory corresponding to the selected options (e.g. `build-gcc`) which contains a subfolder for each
  DUNE module.

* The created Python bindings of each DUNE module are now available within the respective subdirectories of the build
  directory. To make use of the bindings:

  - Create and activate you favorite virtualenv with python3 as interpreter or use the prepared virtualenv:

    ```
    source PATH.sh
    ```

  - Add the locations of interest to the Python interpreter of the virtualenv:

    ```
    for ii in dune-xt-common dune-xt-grid dune-xt-functions dune-xt-la dune-gdt; do echo "$BASEDIR/build-$OPTS/$ii" > "$(python -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())')/$ii.pth"; done
    ```

  - There is a bug in debian which might trigger an MPI init error when importing the Python modules (see for instance
    https://lists.debian.org/debian-science/2015/05/msg00054.html). As a woraround, set

    ```
    export OMPI_MCA_orte_rsh_agent=/bin/false
    ```

    or append this command to `PATH.sh` and source it again.

* There are jupyter notebooks available with some demos. Either `pip install notebook` in your favorite virtualenv or
  use the prepared one. Calling

  ```
  ./start_notebook_server.py
  ```

  should open your browser and show the notebooks.

