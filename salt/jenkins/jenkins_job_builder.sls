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

git_repo:
   git.latest:
    - cwd: {{ pillar['jenkins']['path'] }}
    - name: https://github.com/openstack-infra/jenkins-job-builder.git 
    - target: {{ pillar['jenkins']['job-builder-path'] }}
    - force: True
    - order: 1

install_job_builder:
  cmd.run:
    - name: python setup.py install
    - cwd:  {{ pillar['jenkins']['job-builder-path'] }}
    - order: 2

/etc/jenkins_jobs/jenkins_jobs.ini:
  file:
    - managed
    - source: salt://jenkins/jenkins_jobs.ini
    - order: 3
