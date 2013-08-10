base:
  '*stage*':
    - users
  '*dev*':
    - users

stage:
  '*skunworkers*':
#   - drizzle.ubuntu
#   - jenkins.ubuntu
    - jenkins.jenkins_job_builder
    - salt-master
    - sysbench
