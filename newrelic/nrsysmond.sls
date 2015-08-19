# https://github.com/saltstack-formulas/newrelic-formula

newrelic-sysmond:
  pkg:
    - installed


# Added file.managed as we have to replace more than 1 string
  file.managed:
    - name: /etc/newrelic/nrsysmond.cfg
    - source: salt://newrelic/files/nrsysmond.cfg.jinja
    - template: jinja
    - user: newrelic
    - group: newrelic
    - mode: 6400
    - require:
      - pkg: newrelic-sysmond

#  file.replace:
#    - name: /etc/newrelic/nrsysmond.cfg
#    - pattern: "license_key=REPLACE_WITH_REAL_KEY"
#    - repl: "license_key={{ salt['pillar.get']('newrelic:apikey', '') }}"
#    - require:
#        - pkg: newrelic-sysmond
#
#  # Replace hostname to appear as gateway or something else
#  file.replace:
#    - name: /etc/newrelic/nrsysmond.cfg
#    - pattern: "#hostname=myhost"
#    - repl: "hostname={{ salt['grains.get']('id', '') }}"
#    - require:
#        - pkg: newrelic-sysmond


  service.running:
    - reload: True
    - watch:
        - pkg: newrelic-sysmond
        - file: /etc/newrelic/nrsysmond.cfg
