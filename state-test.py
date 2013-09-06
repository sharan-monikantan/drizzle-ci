#!/usr/bin/python2.7
#
# ==========================
# Test script for drizzle-ci
# ==========================


# imports
import os
import subprocess
import logging
import re


# configuring paths
path = {}
path['root'] = os.getcwd()
path['state'] = '/srv/salt'
path['pillar'] = '/srv/pillar'


# configuring variables

logging.basicConfig(format='%(levelname)s:%(message)s',level=logging.INFO)
log = logging.getLogger(__name__)

command = {}
command['copy'] = 'sudo cp -r {0} {1}'
command['salt'] = r'sudo salt \{0} {1}'

minions = []
states = []
top_file = '''base:
  '*':
    - {0}
'''
output = None

# configuring params
minions.append('minion-ubuntu')

log.info('setting up the test environment')

# setting up the test environment
cmd = command['copy'].format(path['state']+'/top.sls',path['state']+'/top.sls.bak')
os.system(cmd)
cmd = command['copy'].format(path['root']+'/salt',path['state'])
os.system(cmd)
cmd = command['copy'].format(path['root']+'/pillar', path['pillar'])
os.system(cmd)

# refreshing pillar data
log.info('setting up pillar data')
for minion in minions:
    pillar = subprocess.Popen(['sudo','salt',minion,'saltutil.refresh_pillar'],stdout=subprocess.PIPE)

test_state = top_file.format('sysbench')

with open(path['state']+'/top.sls', 'w') as top_sls:
    top_sls.write(test_state)

#for minion in minions:
    #os.system(salt.format(minion, 'state.highstate'))

output = subprocess.Popen(['sudo', 'salt', 'minion-ubuntu', 'state.highstate'], stdout=subprocess.PIPE)
result, error = output.communicate()
if error is not None:
    logging.info(error)
print 'is_string:'+str(isinstance(result,basestring))
regex = re.search(r'Result:\s+False',result)
if regex is not None:
    status = 'FAILURE'
else:
    status = 'OK'
log.info(status)
#print 'result:'+result
#if error is not None:
#    print 'error:'+error

# restoring the original top.sls and cleaning up..
cmd = 'sudo mv {0} {1}'.format(path['state']+'/top.sls.bak', path['state']+'/top.sls')
os.system(cmd)
