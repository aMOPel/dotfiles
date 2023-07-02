#!/bin/bash

export PYTHONPATH=$XDG_DATA_HOME/lib/python3.10/site-packages
/usr/bin/pip3 install pynvim
/usr/bin/pip3 install grip

sudo chsh $USER -s $(which bash)

nvim +PackerInstall
