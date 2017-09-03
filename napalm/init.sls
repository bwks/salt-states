{% if grains['os_family' == 'RedHat' %}
python2-pip:
{% elif grains['os_family' == 'Debian' %}
python-pip:
  pkg:
    - installed
