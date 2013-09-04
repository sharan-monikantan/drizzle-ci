pip:
  cmd:
    - run
    - name: sudo apt-get install python-pip
    - order: 1

novaclient:
  cmd:
    - run
    - name: sudo pip install rackspace-novaclient
    - order: 2

nova:
  file.touch:
    - name: {{ pillar['nova']['path'] }}/nova-{{ pillar['nova']['client'] }}
    - order: 3

credentials:
  file:
    - managed
    - name: {{ pillar['nova']['path'] }}/nova-{{ pillar['nova']['client'] }}
    - source: salt://nova/nova-{{ pillar['nova']['client'] }}
    - user: root
    - order: 3

source:
  cmd:
    - run
    - name: source {{ pillar['nova']['path'] }}/nova-{{ pillar['nova']['client'] }}
    - order: 4
