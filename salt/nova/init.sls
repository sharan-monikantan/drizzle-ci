novaclient:
  cmd:
    - run
    - name: sudo pip install rackspace-novaclient
    - order: 1

nova-credential:
  file.touch:
    - name: /home/user/nova-credentials
    - order: 2

credentials:
  file:
    - managed
    - name: /home/user/nova-credentials
    - source: salt://nova/nova-credentials
    - user: root
    - order: 3

source:
  cmd:
    - run
    - name: source /home/user/nova-credentials
    - order: 4
