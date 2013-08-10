salt_add_key:
  cmd:
    - run
    - name: echo deb http://ppa.launchpad.net/saltstack/salt/ubuntu `lsb_release -sc` main | sudo tee /etc/apt/sources.list.d/saltstack.list ; wget -q -O- "http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0x4759FA960E27C0A6" | sudo apt-key add - ; sudo apt-get update ; 

salt_install:
  cmd:
    - run
    - name: sudo apt-get install salt-master ; sudo apt-get install salt-minion ; sudo apt-get install salt-syndic
    - require:
      - cmd: salt_add_key
