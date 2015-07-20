spm_repo_file:
  file.managed:
    - name: /etc/salt/spm.repos.d/spm_test_repo.conf
    - source: salt://spm/files/spm_test_repo.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
