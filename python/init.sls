{% from 'python/map.jinja' import required_packages with context %}

python-install-required-packages:
  pkg:
    - installed
    - pkgs:
        {{ required_packages.pkgs }}

Python-3.6.4.tgz:
  file.managed:
    - name: /tmp/Python-3.6.4.tgz
    - source: https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
    - source_hash: 9de6494314ea199e3633211696735f65

extract_python:
  archive.extracted:
    - name: /tmp
    - source: /tmp/Python-3.6.4.tgz

py_build:
  cmd.run:
    - cwd: /tmp/Python-3.6.4
    - user: root
    - name: |
        ./configure --prefix=/usr/local
        make altinstall
    - unless: stat /usr/local/bin/python3.6

/usr/bin/python3.6:
  file.symlink:
    - target: /usr/local/bin/python3.6
