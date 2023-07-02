#!/bin/bash

pip3 install pynvim
pip3 install grip

sudo chsh $USER -s $(which bash)

nvim +PackerInstall
