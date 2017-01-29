#!/bin/bash

export NOTEBOOK_PATH=$PWD/notebooks
export NOTEBOOK_PORT=18881

jupyter-notebook --notebook-dir=$NOTEBOOK_PATH --port=$NOTEBOOK_PORT

