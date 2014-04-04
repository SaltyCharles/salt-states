{% if 'prod' in grains.get('roles', []) %}
/etc/newrelic/newrelic.ini:
    file.managed:
        - source: salt://consumeraffairs/newrelic.jinja
        - template: jinja
        - mode: 644
        - mkdirs: True
{% endif %}
