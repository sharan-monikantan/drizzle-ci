novaclient:
  cmd:
    - run
    - name: sudo pip install rackspace-novaclient
    - order: 1

nova-credential:
  file.touch:
    - name: {{ pillar['nova']['path'] }}/nova-credentials
    - order: 2

credentials:
  file:
    - managed
    - name: {{ pillar['nova']['path'] }}/nova-credentials
    - source: salt://nova/nova-credentials
    - user: root
    - order: 3

source:
  cmd:
    - run
    - name: source {{ pillar['nova']['path'] }}/nova-credentials
    - order: 4
