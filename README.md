```
# This file is part of the locally-conservative-rb project:
#   https://github.com/ftalbrecht/locally-conservative-rb
# Copyright holders: Felix Schindler
# License: BSD 2-Clause License (http://opensource.org/licenses/BSD-2-Clause)
```

[locally-conservative-rb](https://github.com/ftalbrecht/locally-conservative-rb)
is a git supermodule which serves as a demonstration for locally conservative
reduced basis (RB) methods. If you have any questions, do not hesitate to
[contact me](http://felixschindler.net/).

In order to build everything, do the following:

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
  selecting `OPTS=gcc-debug.ninja`, which usually speeds up builds significantly.
  
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

* Update the local build environment to make use of the virualenv:

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

* Symlink the build directory to allow automatic discovery of the generated python
  bindings:

  ```
  ln -s build-$OPTS build
  ```

* Start the jupyter notebook server and take a look at the notebooks:

  ```
  ./start_notebook_server.py
  ```
