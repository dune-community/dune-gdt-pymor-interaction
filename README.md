```
# This file is part of the dune-gdt-pymor-interaction project:
#   https://github.com/dune-community/dune-gdt-pymor-interaction
# Copyright holders: Felix Schindler
# License: BSD 2-Clause License (http://opensource.org/licenses/BSD-2-Clause)
```

[dune-gdt-pymor-interaction](https://github.com/dune-community/dune-gdt-pymor-interaction)
is a git supermodule which serves as a demonstration for the interaction between
[dune-gdt](https://github.com/dune-community/dune-gdt) and [pymor](http://pymor.org).

In order to build everything, do the following:

* Install required software (the following list is not yet complete):

  - compiler: we currently recommend gcc >= 5.0
  - metis and parmetis: if these are not available on your system you can enable the
    respective sections in `external-libraries.cfg` _and_ update the build command
    for `alugrid` accordingly

* Initialize all submodules:

  ```
  git submodule update --init --recursive
  ```
  
* Take a look at `config.opts/` and find settings and a compiler which suits your
  system, e.g. `config.opts/gcc-debug`. Select one of those options by defining
  
  ```
  export OPTS=gcc-debug
  ```

  If you have the `ninja` generator installed we recommend to make use of it by
  selecting `OPTS=gcc-debug.ninja` (if such a file exists), which usually speeds up
  builds.
  
* Call

  ```
  ./local/bin/gen_path.py
  ```
  
  to generate a file `PATH.sh` which defines a local build environment. From now
  on you should source this file whenever you plan to work on this project, e.g.:
  
  ```
  source PATH.sh
  ```

* Download and build all external libraries by calling (this _might_ take some time):

  ```
  ./local/bin/download_external_libraries.py
  ./local/bin/build_external_libraries.py
  ```

  This will in particular create a small Python virtualenv for the jupyter notebook,
  the configuration of which can be adapted by editing the virtualenv section
  `external-libraries.cfg` (see below). This virtualenv will be activated from now on,
  whenever `PATH.sh` is sourced again. If you do not wish to make use of the virtualenv,
  simply disable the respective section in `external-libraries.cfg`. Due to a bug in
  dune-python, however, we currently require this virtualenv:

  ```
  source PATH.sh
  ```

* Build all DUNE modules using `cmake` and the selected options (this _will_ take
  some time):

  ```
  ./dune-common/bin/dunecontrol --opts=config.opts/$OPTS --builddir=$PWD/build-$OPTS all
  ```
  
  This creates a directory corresponding to the selected options
  (e.g. `build-gcc-debug`) which contains a subfolder for each DUNE module.

* The created Python bindings of each DUNE module are now available within the
  respective subdirectories of the build directory. Possible ways to make use of these are:

  (i) Create the following symlink and source the PATH.sh again:

      ```
      ln -s build-$OPTS build && . PATH.sh
      ```

      This will activate the virtualenv with an adapted Python path. Afterwards,
      start the jupyter notebook server and take a look at the notebooks:

      ```
      ./start_notebook_server.py
      ```

  (ii) Create and/or source your desired virtualenv and add the required locations to the
       Python path, e.g. by calling

       ```
       for ii in dune-xt-common dune-xt-grid dune-xt-functions dune-xt-la dune-gdt; do echo "$BASEDIR/build-$OPTS/$ii" > "$(python -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())')/$ii.pth"; done
       ```

