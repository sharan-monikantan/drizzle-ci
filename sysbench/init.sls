python-setuptools:
  pkg:
    - installed

easy_install:
  cmd:
    - run
    - name: sudo easy_install -U distribute
    - require:
      - pkg: python-setuptools

mysqldb:
  cmd:
    - run
    - name: sudo pip install MySQL-python
    - require:
      - cmd: easy_install

sysbench:
  pkg:
    - installed
