#!/bin/bash
# 
# git-xflow -- An extension to git-flow, which automatize
# some usual tasks related to repository operations.
#
# Feel free to contribute to this project at:
#    https://github.com/golflima/git-xflow
# git-flow : http://github.com/nvie/gitflow
#
# Copyright 2016 Jérémy Walther (jeremy.walther@golflima.net).
#
# This file is part of git-xflow.
#
# git-xflow is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# git-xflow is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with git-xflow. If not, see <http://www.gnu.org/licenses/>

# This script install git-xflow on GNU/Linux

[[ "$(type -t git)" = "function" ]] || apt-get install git
cd /opt
git clone https://github.com/golflima/git-xflow.git
cd git-xflow
git submodule update --init --recursive
chmod +x git-xflow
chmod +x git-flow
ln -s /opt/git-xflow/git-xflow /usr/bin/git-xflow
[[ -f '/usr/bin/git-flow' ]] || ln -s /opt/git-xflow/git-flow /usr/bin/git-flow