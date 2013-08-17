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
