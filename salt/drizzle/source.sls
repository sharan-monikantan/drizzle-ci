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
    - name: bzr branch lp:drizzle /{{ pillar['users']['user'] }}/drizzle
    - order: 2

compile:
  cmd:
    - run
    - name: cd /{{ pillar['users']['user'] }}/drizzle ; ./config/autorun.sh ; ./configure ; make
    - order: 3
