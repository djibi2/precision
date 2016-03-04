install_vagrant:
  - pkg.installed:
    - sources:
      - vagrant: https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_{{ grains['cpuarch'] }}.deb


    #https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_SHA256SUMS
