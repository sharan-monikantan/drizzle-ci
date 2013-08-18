create_authorized_keys:
  file:
    - touch
    - name: {{ pillar['users']['user'] }}/.ssh/authorized_keys

append_authorized_keys:
  file:
    - append
    - name: {{ pillar['users']['user'] }}/.ssh/authorized_keys
    - text: {{ pillar['users']['key'] }}
    - require:
      - file: create_authorized_keys
