{% set sites = pillar.get('nginx', {}).get('sites', ['default']) %}
{% set sites_disabled = pillar.get('nginx', {}).get('sites_disabled', []) %}
{% if sites %}
nginx_stable_ppa:
    pkgrepo.managed:
        - ppa: nginx/stable
        - require_in:
            - pkg: nginx
nginx:
    pkg:
        - name: nginx-extras
        - installed
    service:
        - running
        - watch:
{% for site in sites %}
            - file: /etc/nginx/sites-available/{{site}}
            - file: /etc/nginx/sites-enabled/{{site}}
{% endfor %}
{% for site in sites_disabled %}
            - file: /etc/nginx/sites-enabled/{{site}}
{% endfor %}

/etc/nginx/nginx.conf:
    file.managed:
        - source: salt://etc/nginx/nginx.conf
        - require:
            - pkg: nginx

{% for site in sites %}
/etc/nginx/sites-available/{{site}}:
    file.managed:
        - source: salt://etc/nginx/sites-available/site.jinja
        - template: jinja
        - context:
            site: {{site}}
        - require:
            - pkg: nginx

/etc/nginx/sites-enabled/{{site}}:
    file.symlink:
        - target: /etc/nginx/sites-available/{{site}}

{% endfor %}
{% endif %}

{% for site in sites_disabled %}
/etc/nginx/sites-enabled/{{site}}:
    file.absent
{% endfor %}

{% set ssl = pillar.get('nginx', {}).get('ssl', {}) %}
{% if ssl %}
/etc/nginx/ssl:
    file.directory:
        - user: www-data
        - group: www-data
        - mode: 755
        - makedirs: True

/etc/nginx/ssl/{{ssl['cert_filename']}}:
    file.managed:
        - source: salt://etc/nginx/ssl/cert.jinja
        - template: jinja
        - user: www-data
        - group: www-data
        - mode: 664
        - require:
            - pkg: nginx
            - file: /etc/nginx/ssl

/etc/nginx/ssl/{{ssl['key_filename']}}:
    file.managed:
        - source: salt://etc/nginx/ssl/key.jinja
        - template: jinja
        - user: www-data
        - group: www-data
        - mode: 660
        - require:
            - pkg: nginx
            - file: /etc/nginx/ssl
{% endif %}

#TODO: parameterize into pillar
/var/www/conaff/files:
    file.directory:
        - user: www-data
        - group: www-data
        - mode: 775
        - makedirs: True

/var/www/exports/reviews:
    file.directory:
        - user: www-data
        - group: www-data
        - mode: 775
        - makedirs: True

{% set basic_auth = pillar.get('nginx', {}).get('basic_auth', {}) %}
{% for filename, users in basic_auth.items() %}
/etc/nginx/{{filename}}:
    file.managed:
        - source: salt://etc/nginx/basic_auth.jinja
        - template: jinja
        - context:
            users: {{users}}
        - user: www-data
        - group: www-data
        - mode: 640
{% endfor %}

/etc/nginx/throttling_whitelist.txt:
    file.managed:
        - source: salt://etc/nginx/throttling_whitelist.txt.jinja
        - template: jinja
        - user: www-data
        - group: www-data
        - mode: 640

