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


# Installation for Ubuntu

ubuntu_install_stage_1:
  cmd:
    - run
    - name: wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

ubuntu_install_stage_2:
  cmd:
    - run
    - name: sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    - require:
      - cmd: ubuntu_install_stage_1

ubuntu_install_stage_3:
  cmd:
    - run
    - name: sudo apt-get update
    - require:
      - cmd: ubuntu_install_stage_2

ubuntu_install:
  cmd:
    - run
    - name: sudo apt-get install jenkins
    - require:
      - cmd: ubuntu_install_stage_3
