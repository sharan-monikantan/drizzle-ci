The DrizzleCI Infrastrucutre
============================

The drizzle-ci repository contains the essentials to setup the Continuous Integration system. This infrastructure provides the following advantages:

- Relieves the cost of maintaining permanent servers
- Creates test servers on demand
- Provides parallelism
- Served with automation

First we need to clone the repository and setup the environment:

Clone the repository
  ``git clone https://github.com/sharan-monikantan/drizzle-ci.git``
  
Setup
-----
  The drizzle-ci/setup directory contains a *config* file. This file contains a few configurations that must be set prior setup. 
  The config file contains some default values and users can leave those defaults as such. 
  The ``CI_HOME`` variable *should be set* without fail. This CI_HOME is the location where the drizzle-ci repository lies in the local machine. 
  For example, if drizzle-ci repository lies in /home/foo, then */home/foo/drizzle-ci* is the value for CI_HOME.
  Once all variables are set, then perform ``source /setup/config``
  
  The next step is to setup the state file and pillar data in respecitive paths :
  ``sudo -E ./setup.sh`` 
  That does pretty much all the work to setup the files. The log file for setup resides in the CI_HOME path as ``.drizzle-ci-log``.
  
  Once setup is complete the pillar data for the following modules should be filled in:
  
  - cloud
  - salt -> master-ip-address
  - jenkins
  - users 
  
  Now the users have two choices:
  
  1. use salt-cloud for creating nodes: This creates a node, installs salt-minion on it, and adds its key in the master.
  2. use nova for spinning up nodes: Needs explicit installation of salt-minion on the nodes.
  
  If salt-cloud is your call, then run the cloud.sh script. ``sudo -E ./cloud.sh MASTER_ID``, where MASTER_ID is the name of master node. This has to be passed explicitly as an argument to the script. 
  Usually it is the same as $HOSTNAME.
  This should setup the provider configuration files and profile configuration files specific to your client ( eg, rackspace ), which is set in the cloud pillar data. 
  And before spinning up cloud nodes via salt-cloud, salt-cloud itself has to be installed : ``pip install git+https://github.com/saltstack/salt-cloud.git#egg=salt_cloud``
  
  If nova is your choice, then run nova.sh with ``sudo -E ./nova.sh MASTER_ID``.
  This will setup python-novaclient on the master.
  Then run the salt.sh with ``sudo -E ./salt.sh``. This should install salt on all the created nodes.
  

Once setup is complete, all that you have to do is one last thing. ``sudo salt \* state.highstate`` and it takes care of the magical work of setting up all nodes to required state.
And CI system is ready to use!
  
  
