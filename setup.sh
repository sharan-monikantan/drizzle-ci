#!/bin/bash
#
# the setup script for setting up the drizzle-ci

echo "Starting setup..."

# Declaring the required env vars
set STATE_BASE
set PILLAR_BASE
set CLOUD_PROVIDERS
set CLOUD_PROFILES

# Function to read config file and setup the env vars
read_config()
{
    count=0
    while read param
    do
        string= echo $param | grep =
        if [ $string = ""]; then
            continue
        fi
        ENV_VAR[$count]= echo $param | cut -d = -f2
        (( count++ ))
    done < setup-config

    STATE_BASE= ${ENV_VAR[0]}
    PILLAR_BASE= ${ENV_VAR[1]}
    CLOUD_PROVIDERS= ${ENV_VAR[2]}
    CLOUD_PROFILES= ${ENV_VAR[3]}    
}

echo "Reading config file..."
read_config

echo "setting up directories..."
sudo cp -r ./salt $SALT_BASE 
sudo cp -r ./pillar $PILLAR_BASE
sudo cp -r ./cloud/cloud.providers.d $CLOUD_PROVIDERS
sudo cp -r ./cloud/cloud.profiles.d $CLOUD_PROFILES

# Clearing variables
unset STATE_BASE
unset PILLAR_BASE
unset CLOUD_PROVIDERS
unset CLOUD_PROFILES

echo "setup complete..."
