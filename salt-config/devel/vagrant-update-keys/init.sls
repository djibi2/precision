git:
  pkg:
    - installed
  user:
    - present
    - home: /home/rhedges

/opt/vagrant-update-keys
  file.directory:
    - user: rhedges
    - group: rhedges
    - dir_mode: 0755
    - require:
      - user: rhedges

/home/rhedges/.ssh:
  file.directory:
    - user: rhedges
    - group: rhedges
    - dir_mode: 775
    - require:
      - user: rhedges

git-key:
  file.managed:
    - name: /home/rhedges/.ssh/id_rsa
    - source: salt://devel/vagrant-update-keys/keys/id_rsa_workstation
    - user: rhedges
    - group: rhedges
    - mode: 400
    - require:
      - file: /home/rhedges/.ssh

bitbucket.com:
  ssh_known_hosts:
    - present
    - user: rhedges
    - fingerprint: 97:8c:1b:f2:6f:14:6b:5c:3b:ec:aa:46:46:74:7c:40
    - require:
      - user: rhedges

github.com:
  ssh_known_hosts:
    - present
    - user: rhedges
    - fingerprint:  16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
    - require:
      - user: rhedges

git-repo:
  git.latest:git
    - name: git@bitbucket.org:truefitness/vagrant-update-keys.git
    - rev: master
    - user: rhedges
    - target: /opt/vagrant-update-keys
    - require:
        - pkg: git
        - file: /opt/vagrant-update-keys
        - ssh_known_hosts: bitbucket.com
