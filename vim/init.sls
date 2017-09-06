{% from 'vim/map.jinja' import vim with context %}

install-vim:
  pkg.installed:
    - name: {{ vim.pkg }}
