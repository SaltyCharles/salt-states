/usr/local/bin/python_uptodate.py:
    file.managed:
        - source: salt://usr/local/bin/python_uptodate.py.jinja
        - template: jinja
        - mode: 755
        - user: www-data
        - group: www-data
        - require:
            - pkg: python
    

source ~/.virtualenvs/ca/bin/activate && /usr/local/bin/python_uptodate.py:
    cron.present:
        - user: www-data
        - minute: 3
        - hour: 4
        - dayweek: 1
        - comment: inform about python packages available updates
