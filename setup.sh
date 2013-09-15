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
#
# Setup script for drizzle-ci

echo "Starting setup..."
if [ -f /var/tmp/drizzle-ci-log ];
then
    sudo rm /var/tmp/drizzle-ci-log
    sudo touch /var/tmp/drizzle-ci-log
fi

# setting up path variables
echo "Setting environment variables..."
source setup-config

# creating the directories
echo "setting up directories..."

if [ ! -d $STATE_BASE ]; then
    sudo mkdir $STATE_BASE
fi

if [ ! -d $PILLAR_BASE ]; then
    sudo mkdir $PILLAR_BASE
fi

if [ ! -d /etc/salt/cloud.providers.d ]; then
    sudo mkdir /etc/salt/cloud.providers.d
fi

if [ ! -d /etc/salt/cloud.profiles.d ]; then
    sudo mkdir /etc/salt/cloud.profiles.d
fi

# placeing the required files
echo "populating directories..."
sudo cp -r ./salt/* $STATE_BASE >> /var/tmp/drizzle-ci-log 2>&1
sudo cp -r ./pillar/* $PILLAR_BASE >> /var/tmp/drizzle-ci-log 2>&1
sudo cp -r ./cloud/cloud.providers.d/$CLOUD_PROVIDER.conf /etc/salt/cloud.providers.d/ >> /var/tmp/drizzle-ci-log 2>&1
sudo cp -r ./cloud/cloud.profiles.d/$CLOUD_PROVIDER.conf /etc/salt/cloud.profiles.d/ >> /var/tmp/drizzle-ci-log 2>&1

if [ -s /var/tmp/drizzle-ci-log ];
then
echo "THERE SEEMS TO BE SOME ERROR / WARNING. CHECK OUT THE LOG FILE"
fi

# Clearing variables
unset STATE_BASE
unset PILLAR_BASE
unset CLOUD_PROVIDER

sudo salt $1 state.highstate >> /var/tmp/drizzle-ci-log
echo "setup complete... To know more, check out the log file"
