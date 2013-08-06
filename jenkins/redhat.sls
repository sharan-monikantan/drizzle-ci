# Installation for RedHat

redhat_install_stage_1:
  cmd:
    - run
    - name: sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo

redhat_install_stage_2:
  cmd:
    - run
    - name: sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
    - require:
      - cmd: redhat_install_stage_1

redhat_install:
  cmd:
    - run
    - name: sudo yum install jenkins
    - require:
      - cmd: redhat_install_stage_2

