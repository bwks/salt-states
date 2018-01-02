{% from 'python/map.jinja' import required_packages with context %}

python-install-required-packages:
  pkg:
    - installed
    - pkgs:
        {{ required_packages.pkgs }}

