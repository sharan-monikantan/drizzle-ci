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

/etc/salt/cloud.profiles.d/{{ pillar['cloud']['client'] }}.conf:
  file.managed:
    - source: salt://cloud/profiles/{{ pillar['cloud']['client'] }}.conf
    - template: jinja

/etc/salt/cloud.providers.d/{{ pillar['cloud']['client'] }}.conf:
  file.managed:
    - source: salt://cloud/providers/{{ pillar['cloud']['client'] }}.conf
    - template: jinja

python-libcloud:
  pkg:
    - installed

git:
  pkg:
    - installed

python-pip:
  pkg:
    - installed
