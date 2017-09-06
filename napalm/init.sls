{% from 'napalm/map.jinja' import pip with context %}
{% from 'napalm/map.jinja' import packages with context %}

pip:
  pkg.installed:
    - name: {{ pip.pkg }}

setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - require:
      - pkg: {{ pip.pkg }}

required_packages:
  pkg:
    - installed
    - pkgs:
        {{ packages.pkgs }}

napalm:
  pip.installed:
    - name: napalm
    - require:
      - pkg: {{ pip.pkg }}
