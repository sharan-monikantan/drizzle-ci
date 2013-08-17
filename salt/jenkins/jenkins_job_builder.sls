git_repo:
   git.latest:
#   - cwd: /home/user
    - name: https://github.com/openstack-infra/jenkins-job-builder.git 
#   - target: /home/user/jenkins-job-builder
    - force: True
    - order: 1

install_job_builder:
  cmd.run:
    - name: python setup.py install
#   - cwd:  /home/user/jenkins-job-builder
    - order: 2

/etc/jenkins_jobs/jenkins_jobs.ini:
  file:
    - managed
    - source: salt://jenkins/jenkins_jobs.ini
    - order: 3
