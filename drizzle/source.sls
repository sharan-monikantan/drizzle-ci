stage_1:
  cmd:
    - run
    - name: sudo add-apt-repository ppa:drizzle-developers/ppa
    - order: 0

stage_2:
  cmd:
    - run
    - name: sudo apt-get update
    - order: 1

stage_3:
  pkg.installed:
    - pkgs:
      - python-software-properties
      - drizzle-dev
      - bzr
      - make
      - libboost-test-dev
      - libcloog-ppl0
    - order: 2

fetch_source:
  cmd:
    - run
    - name: bzr branch lp:drizzle /home/shar/drizzle
    - order: 3

compile:
  cmd:
    - run
    - name: cd /home/shar/drizzle ; ./config/autorun.sh ; ./configure ; make ; make install
    - order: 4
