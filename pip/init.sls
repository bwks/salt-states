{% from 'pip/map.jinja' import pip with context %}

install-pip:
  pkg.installed:
    - name: {{ pip.pkg }}

upgrade-setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - require:
      - pkg: {{ pip.pkg }}
