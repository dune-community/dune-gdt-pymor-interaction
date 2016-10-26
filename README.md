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

  ```bash
  git submodule update --init --recursive
  ```
  
* Take a look at `config.opts/` and find settings and a compiler which suits your
  system, e.g. `config.opts/gcc-debug`. Select one of those options by defining
  
  ```bash
  export OPTS=gcc-debug
  ```
  
* Call

  ```bash
  ./local/bin/gen_path.py
  ```
  
  to generate a file `PATH.sh` which defines a local build environment. From now
  on you should source this file whenever you plan to work on this project, e.g.:
  
  ```bash
  source PATH.sh
  ```

* Download and build all external libraries by calling (this _might_ take some time):

  ```bash
  ./local/bin/download_external_libraries.py
  ./local/bin/build_external_libraries.py
  ```

* Build all DUNE modules using `cmake` and the selected options (this _will_ take
  some time):

  ```bash
  ./dune-common/bin/dunecontrol --opts=config.opts/$OPTS --builddir=$PWD/build-$OPTS all
  ```
  
  This creates a directory corresponding to the selected options
  (e.g. `build-gcc-debug`) which contains a subfolder for each DUNE module. 
