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
