{% from 'master-files/map.jinja' import download_files with context %}

{% for file in download_files %}
download-file-{{ file.name }}:
  file.managed:
    - name: /srv/salt/files/{{ file.name }}
    - source: {{ file.source }}/{{file.name }}
  {% if not file.hash %}
    - skip_verify: True
  {% else %}
    - source_hash: {{ file.hash }}
  {% endif %}
{% endfor %}
