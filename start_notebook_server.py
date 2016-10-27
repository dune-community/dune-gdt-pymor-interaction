#!/bin/bash

if [[ ! -e PATH.sh ]] ; then
  echo "Missing PATH.sh, exiting!"
  exit 1
fi
. PATH.sh

export NOTEBOOK_PATH=$BASEDIR/notebooks
export NOTEBOOK_PORT=18881

jupyter-notebook --notebook-dir=$NOTEBOOK_PATH --port=$NOTEBOOK_PORT
