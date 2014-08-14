# Install PHP and extensions
libmysqlclient18:
  pkg.installed

php:
  pkg.installed:
    - pkgs:
      - php5
      - php5-dev
      - php5-cli
      - php5-curl
      - php5-gd
      - php5-gmp
      - php5-imagick
      - php5-intl
      - php5-mcrypt
      - php5-memcache
      - php5-mysql
