/usr/local/bin/ssl_check.py:
    file.managed:
        - source: salt://usr/local/bin/ssl_check.py.jinja
        - template: jinja
        - mode: 755
        - user: root
        - group: root
    

/bin/bash -c "/usr/local/bin/ssl_check.py" > /dev/null:
    cron.present:
        - user: root
        - minute: 3
        - hour: 6
        - dayweek: 1
        - comment: inform about ssl check (SSL Labs)