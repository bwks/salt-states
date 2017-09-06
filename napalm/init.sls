{% from 'pip/map.jinja' import pip with context %}
{% from 'napalm/map.jinja' import packages with context %}

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
