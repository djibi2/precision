virtualbox-repo:
  pkgrepo.managed:
    - name: "deb http://download.virtualbox.org/virtualbox/debian {{ grains['oscodename'] }} contrib"
    - file: /etc/apt/sources.list.d/virtualbox-{{ grains['oscodename']}}.list
    - humanname: Virtualbox repo for Ubuntu
    - keyserver: https://www.virtualbox.org/download/oracle_vbox.asc
    - keyid: oracle_vbox.asc
    - dist: {{ grains['oscodename'] }}

virtualbox-install:
  pkg.installed:
    - name: virtualbox
    - require:
      - pkgrepo: 'virtualbox-repo'
