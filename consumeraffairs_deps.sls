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

sync_updates_script:
    file.managed:
        - name: /usr/local/bin/sync_uploads.sh
        - source: salt://usr/local/bin/sync_uploads.sh.jinja
        - template: jinja
        - mode: 755
        - user: www-data
        - group: www-data
