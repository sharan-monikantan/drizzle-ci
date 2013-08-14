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

source:
  cmd:
    - run
#   - name: bzr branch lp:drizzle /home/user/drizzle drizzle-trunk
    - order: 2

compile:
  cmd:
    - run
#   - name: cd /home/user/drizzle ; ./config/autorun.sh ; ./configure ; make 
    - order: 3
