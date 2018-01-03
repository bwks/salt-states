{% from 'python/map.jinja' import required_packages with context %}
{% from 'python/map.jinja' import python_versions with context %}


python-install-required-packages:
  pkg:
    - installed
    - pkgs:
        {{ required_packages.pkgs }}

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
    - force: True
{% endfor %}
