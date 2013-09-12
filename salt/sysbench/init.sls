#
#    This file is part of drizzle-ci
#
#    Copyright (c) 2013 Sharan Kumar M
#
#    drizzle-ci is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    drizzle-ci is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with drizzle-ci.  If not, see <http://www.gnu.org/licenses/>.

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
