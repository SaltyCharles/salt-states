include:
    - python
    - PIL_deps
    - newrelic

consumeraffairs_deps:
    pkg.installed:
        - names:
            - libmysqlclient-dev
            - libenchant-dev
            - libyaml-dev

{% if 'web' in grains.get('roles', []) and 'ca.com' in grains.get('roles', []) %}
sync_updates_script:
    file.managed:
        - name: /usr/local/bin/sync_uploads.sh
        - source: salt://usr/local/bin/sync_uploads.sh.jinja
        - template: jinja
        - mode: 755
        - user: www-data
        - group: www-data

{% if 'prod' in grains.get('roles', []) %}
sync_cron_uploads:
    cron.present:
        - names:
            - /usr/local/bin/sync_uploads.sh
            - sleep 30; /usr/local/bin/sync_uploads.sh
        - user: www-data
        - minute: '*'
{% endif %}
{% endif %}
