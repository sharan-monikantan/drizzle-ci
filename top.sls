base:
  '*stage*':
    - users
  '*dev*':
    - users

stage:
  '*skunworkers*':
#   - jenkins.ubuntu
    - jenkins.jenkins_job_builder
    - salt-master
