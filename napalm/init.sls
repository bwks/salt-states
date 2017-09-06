{% from 'napalm/map.jinja' import pip with context %}
{% from 'napalm/map.jinja' import packages with context %}

install-pip:
  pkg.installed:
    - name: {{ pip.pkg }}

upgrade-setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - require:
      - pkg: {{ pip.pkg }}

install-required-packages:
  pkg:
    - installed
    - pkgs:
        {{ packages.pkgs }}

install-napalm:
  pip.installed:
    - name: napalm
    - require:
      - pkg: {{ pip.pkg }}
