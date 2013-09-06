python-setuptools:
  pkg:
    - installed

python-pip:
  pkg:
    - installed
    - require:
      - pkg: python-setuptools

easy_install:
  cmd:
    - run
    - name: sudo easy_install -U distribute
    - require:
      - pkg: python-setuptools

libmysqlclient-dev:
  pkg:
    - installed

drizzle-dev:
  pkg:
    - installed

mysqldb:
  cmd:
    - run
    - name: sudo pip install MySQL-python
    - require:
      - cmd: easy_install
      - pkg: python-pip
      - pkg: libmysqlclient-dev
      - pkg: drizzle-dev

sysbench:
  pkg:
    - installed 
