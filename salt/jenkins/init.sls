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




fetch_source:
  cmd:
    - run
    - name: wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
    - order: 1

add_source:
  cmd:
    - run
    - name: sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    - order: 2

update_list:
  cmd:
    - run
    - name: sudo apt-get update
    - order: 3

jenkins:
  pkg: 
    - installed
    - order: 4

{{ pillar['jenkins']['path'] }}/jenkins_jobs.ini:
  file.managed:
    - source: salt://jenkins/jenkins_jobs.ini
    - template: jinja
    - order: 5

git_repo:
  git.latest:
    - cwd: {{ pillar['jenkins']['path'] }}
    - name: https://github.com/openstack-infra/jenkins-job-builder.git
    - target: {{ pillar['jenkins']['path'] }}
    - force: True
    - order: 6

install_jenkins_jobs:
  cmd.run:
    - name: python setup.py install
    - cwd: {{ pillar['jenkins']['path'] }}
    - order: 7
