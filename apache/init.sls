apache2:
  pkg:
    - installed
  service:
    - running
    - enable: True

php5:
  pkg:
    - installed
    - require_in:
    - service: apache2
  cmd:
    - run
    - name: a2enmod php5 rewrite
    - require:
      - pkg: php5

/etc/apache2/sites-available/wordpress:
  file.managed:
    - source: salt://apache/wordpress.jinja
    - template: jinja
  
/etc/apache2/sites-enabled/wordpress:
  file.symlink:
    - target: /etc/apache2/sites-available/wordpress

/etc/apache2/sites-enabled/000-default:
  file.absent
