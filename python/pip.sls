{% from 'python/map.jinja' import python_versions with context %}

# Pip installed with the system python is required for the pip module 
install-pip:
  pkg.installed:
    - name: {{ pip.pkg }}

upgrade-setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - require:
      - pkg: {{ pip.pkg }}

get-pip:
  file.managed:
    - name: /tmp/get-pip.py
    - source: https://bootstrap.pypa.io/get-pip.py
    - skip_verify: True

{% for python in python_versions %}
install-pip{{ python.release }}:
  cmd.run:
    - cwd: /tmp
    - user: root
    - name: | 
        /usr/bin/python{{ python.release }} get-pip.py
    - unless: /usr/bin/pip{{ python.release }}

/usr/bin/pip{{ python.release }}:
  file.symlink:
    - target: /usr/local/bin/pip{{ python.version }}

upgrade-setuptools-pip{{ python.release }}:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - bin_env: /usr/bin/pip{{ python.release }}
{% endfor %}
