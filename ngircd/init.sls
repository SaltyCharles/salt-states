ngircd:
  pkg:
    - installed
  service:
    - enable: True
    - running
    - watch:
      - file: /etc/ngircd/ngircd.conf

/etc/ngircd/ngircd.conf:
  file.managed:
    - source: salt://ngircd/ngircd.jinja
    - template: jinja
    - mode: 644
