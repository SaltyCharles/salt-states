/var/www/wordpress:
  cmd:
    - script
    - source: salt://wordpress/setup.sh
    - onlyif: 'test ! -e /var/www/wordpress'

/var/www/wordpress/wp-config.php:
  file.managed:
    - source: salt://wordpress/wp-config.php
    - user: www-data
    - group: www-data
    - template: jinja
    - context:
      mysql_password: hfLpbuXGfpEnVt1
    - order: last
