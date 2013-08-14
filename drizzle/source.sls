libraries:
  pkg.installed:
    - pkgs:
      - python-software-properties
      - drizzle-dev
      - bzr
      - make
      - libboost-test-dev
      - libcloog-ppl0
      - autopoint
      - libmysqlclient-dev
    - order: 1

easy_install:
  cmd:
    - run
    - name: sudo easy_install -U distribute
    - order: 2

mysqldb:
  cmd:
    - run
    - name: sudo pip install MySQL-python
    - order: 3

source:
  cmd:
    - run
#   - name: bzr branch lp:drizzle /home/user/drizzle drizzle-trunk
    - order: 4

compile:
  cmd:
    - run
#   - name: cd /home/user/drizzle ; ./config/autorun.sh ; ./configure ; make 
    - order: 5
