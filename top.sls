base:
  '*stage*':
    - users
  '*dev*':
    - users

stage:
  '*skunworkers*':
    - drizzle
#   - jenkins.ubuntu
    - jenkins.jenkins_job_builder
    - salt-master
    - sysbench
