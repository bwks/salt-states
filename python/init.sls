{% from 'python/map.jinja' import required_packages with context %}
{% from 'python/map.jinja' import python_versions with context %}


python-install-required-packages:
  pkg:
    - installed
    - pkgs:
        {{ required_packages.pkgs }}

{% for key, value in python_versions.items() %}
Python-{{ value.release }}.tgz:
  file.managed:
    - name: /tmp/Python-{{ value.release }}.tgz
    - source: https://www.python.org/ftp/python/{{ value.release }}/Python-{{ value.release }}.tgz
    - source_hash: {{ value.hash }}

extract-python-{{ value.release }}:
  archive.extracted:
    - name: /tmp
    - source: /tmp/Python-{{ value.release }}.tgz

python-build-{{ value.release }}:
  cmd.run:
    - cwd: /tmp/Python-{{ value.release }}
    - user: root
    - name: |
        ./configure --prefix=/usr/local
        make altinstall
    - unless: stat /usr/local/bin/python{{ value.version }}

/usr/bin/python{{ value.version }}:
  file.symlink:
    - target: /usr/local/bin/python{{ value.release }}
    - force: True
{% endfor %}
