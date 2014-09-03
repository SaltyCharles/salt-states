/usr/local/bin/python_uptodate.py:
    file.managed:
        - source: salt://usr/local/bin/python_uptodate.py.jinja
        - template: jinja
        - mode: 755
        - user: www-data
        - group: www-data
    

/bin/bash -c "source /var/www/.virtualenvs/ca/bin/activate && /usr/local/bin/python_uptodate.py" > /dev/null 2>&1:
    cron.present:
        - user: www-data
        - minute: 3
        - hour: 4
        - dayweek: 1
        - comment: inform about python packages available updates
