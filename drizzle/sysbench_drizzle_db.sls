#/home/user/sysbench_db.sql:
  file:
    - managed
    - source: salt://sysbench/sysbench_db.sql

sysbench_db:
  cmd:
    - run
#   - name: drizzle -uroot < /home/user/sysbench_db.sql
    - require:
#     - file: /home/user/sysbench_db.sql

