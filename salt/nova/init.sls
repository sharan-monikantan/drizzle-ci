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

pip:
  cmd:
    - run
    - name: sudo apt-get install python-pip
    - order: 1

novaclient:
  cmd:
    - run
    - name: sudo pip install rackspace-novaclient
    - order: 2

nova:
  file.touch:
    - name: {{ pillar['nova']['path'] }}/nova-{{ pillar['nova']['client'] }}
    - order: 3

credentials:
  file:
    - managed
    - name: {{ pillar['nova']['path'] }}/nova-{{ pillar['nova']['client'] }}
    - source: salt://nova/nova-{{ pillar['nova']['client'] }}
    - user: root
    - order: 3

source:
  cmd:
    - run
    - name: source {{ pillar['nova']['path'] }}/nova-{{ pillar['nova']['client'] }}
    - order: 4
