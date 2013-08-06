create_authorized_keys:
  file:
    - touch
#   - name: /home/user/authorized_keys

append_authorized_keys:
  file:
    - append
#   - name: /home/user/authorized_keys
#   - text: ssh-rsa key
    - require:
      - file: create_authorized_keys
