drizzle_install_stage_1:
  cmd:
    - run
    - name: sudo rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm

drizzle_install:
  cmd:
    - run
    - name: sudo yum install drizzle-server drizzle-client
    - require:
      - cmd: drizzle_install_stage_1
