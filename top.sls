base:
  '*':
    - vim
    - motd
  'os_family:RedHat':
    - match: grain
    - epel-release
    - development-tools
  '*syndic*':
    - pip
    - napalm
#  '*minion*':
  'minion02':
#  'master01':
    - pip
    - python

  'master01':
    - master-files
