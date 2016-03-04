{% set virtualbox_version='5.0' %}

virtualbox-repo:
  pkgrepo.managed:
    - name: "deb http://download.virtualbox.org/virtualbox/debian {{ grains['oscodename'] }} contrib"
    - file: /etc/apt/sources.list.d/virtualbox-{{ grains['oscodename']}}.list
    - humanname: Virtualbox repo for Ubuntu
    - key_url: https://www.virtualbox.org/download/oracle_vbox.asc
    - dist: {{ grains['oscodename'] }}

virtualbox-install:
  pkg.installed:
    - name: virtualbox-{{virtualbox_version}}
    - skip_verify: True
    - require:
      - pkgrepo: 'virtualbox-repo'

virtualbox_ext_pack:
  cmd.run:
    - name: >
            cd /tmp;
            wget -qO - https://www.virtualbox.org/wiki/Downloads |
            grep "vbox-extpack" |
            grep {{virtualbox.version}} |
            sed "s/.\+\(http:\/\/download.virtualbox.org.\+.vbox-extpack\).\+/\1/" |
            xargs wget -O Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack &&
            vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack &&
            rm Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack
    - unless: vboxmanage list extpacks|grep Usable|grep true
    - user: root
    - require:
      - pkg: virtualbox-{{virtualbox_version}}
