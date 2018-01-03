{% from 'python/map.jinja' import required_packages with context %}
{% from 'python/map.jinja' import python_versions with context %}


python-install-required-packages:
  pkg:
    - installed
    - pkgs:
        {{ required_packages.pkgs }}

get-pip:
  file.managed:
    - name: /tmp/get-pip.py
    - source: https://bootstrap.pypa.io/get-pip.py
    - skip_verify: True

{% for python in python_versions %}
Python-{{ python.release }}.tgz:
  file.managed:
    - name: /tmp/Python-{{ python.release }}.tgz
    - source: https://www.python.org/ftp/python/{{ python.release }}/Python-{{ python.release }}.tgz
    - source_hash: {{ python.hash }}

extract-python-{{ python.release }}:
  archive.extracted:
    - name: /tmp
    - source: /tmp/Python-{{ python.release }}.tgz

python-build-{{ python.release }}:
  cmd.run:
    - cwd: /tmp/Python-{{ python.release }}
    - user: root
    - name: |
        ./configure --prefix=/usr/local
        make
        make altinstall
    - unless: stat /usr/local/bin/python{{ python.version }}

/usr/bin/python{{ python.release }}:
  file.symlink:
    - target: /usr/local/bin/python{{ python.version }}

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
