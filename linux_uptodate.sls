/usr/local/bin/linux_uptodate.py:
    file.managed:
        - source: salt://usr/local/bin/linux_uptodate.py.jinja
        - template: jinja
        - mode: 755
        - user: root
        - group: root


/bin/bash -c "/usr/local/bin/linux_uptodate.py" > /dev/null 2>&1:
    cron.present:
        - user: root
        - minute: 34
        - hour: 4
        - dayweek: 1
        - comment: inform about linux packages available updates
