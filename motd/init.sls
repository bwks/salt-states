/etc/motd:
  file.managed:
    - source: salt://motd/motd.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
