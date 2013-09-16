#!/bin/bash
#
#    This file is part of drizzle-ci
#
#    Copyright (c) 2013 Sharan Kumar M
#
#    drizzle-ci is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    drizzle-ci is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with drizzle-ci.  If not, see <http://www.gnu.org/licenses/>.

# backing up the top file
sudo cp $STATE_BASE/top.sls $STATE_BASE/top.sls.bak

# installing nova
sudo cp ./util/nova.sls $STATE_BASE/top.sls
sudo salt $1 state.highstate

# restoring state system
sudo mv $STATE_BASE/top.sls.bak $STATE_BASE/top.sls
