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

/{{ pillar['users']['user'] }}/.ssh:
  file.directory:
    - user: {{ pillar['users']['user'] }}
    - order: 1

create_authorized_keys:
  file:
    - touch
    - name: {{ pillar['users']['user'] }}/.ssh/authorized_keys

append_authorized_keys:
  file:
    - append
    - name: {{ pillar['users']['user'] }}/.ssh/authorized_keys
    - text: {{ pillar['users']['key'] }}
    - require:
      - file: create_authorized_keys
