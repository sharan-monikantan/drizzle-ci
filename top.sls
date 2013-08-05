base:
  '*stage*':
    - users
  '*dev*':
    - users

stage:
  '*skunworkers*':
    - jenkins
    - salt-master
