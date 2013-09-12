#!/usr/bin/python2.7
#
#    This file is part of drizzle-ci
#
#    Copyright (c) 2013 Sharan Kumar M
#
#    drizzle-ci is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    drizzle-ci is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with drizzle-ci.  If not, see <http://www.gnu.org/licenses/>.
#
#
# ==========================
# Test script for drizzle-ci
# ==========================


# imports
import logging
import os
import re
import signal
import subprocess
import sys


# configuring paths
path = {}
path['root'] = os.getcwd()
path['state'] = '/srv/salt'
path['pillar'] = '/srv/pillar'


# configuring variables
logging.basicConfig(format='%(levelname)s:%(message)s',level=logging.INFO)
log = logging.getLogger(__name__)
copy = 'sudo cp -r {0} {1}'
top_file = '''base:
  '*':
    - {0}
'''


# functions
def process_command_line():
    '''
    A function to return the command line arguments as a dictionary of items
    '''
    opt = {}
    argv = sys.argv[1:]

    if len(argv) is 0:
        opt['minion'] = ['*']
        opt['state'] = ['drizzle-dbd','drizzle','jenkins','nova','salt','sysbench','users']
        return opt

    for arg in argv:
        key = arg.split('=')[0][2:]
        opt[key] = arg.split('=')[1].split(',')

    return opt


def keyboard_interrupt(signal_type,handler):
    '''
    This function handles the keyboard interrupt
    '''
    log.info('\t\tPressed CTRL+C')
    log.info('\t\texiting...')
    exit(0)

# processing the command line and kick start!
opt = process_command_line()
signal.signal(signal.SIGINT,keyboard_interrupt)
log.info('\t\tsetting up the environment')


# setting up the environment
cmd = copy.format(path['state']+'/top.sls',path['state']+'/top.sls.bak')
os.system(cmd)
cmd = copy.format(path['root']+'/salt',path['state'])
os.system(cmd)
cmd = copy.format(path['root']+'/pillar', path['pillar'])
os.system(cmd)


# refreshing pillar data
log.info('\t\tsetting up pillar data')
for minion in opt['minion']:
    subprocess.Popen(['sudo','salt',minion,'saltutil.refresh_pillar'],stdout=subprocess.PIPE)


# processing each state
log.info('\n\t\t==================================================')
log.info('\t\tstate               minion              status    ')
log.info('\t\t==================================================')
for state in opt['state']:

    top_data = top_file.format(state)
    with open(path['state']+'/top.sls', 'w') as top_sls:
        top_sls.write(top_data)
    
    for minion in opt['minion']:
        output = subprocess.Popen(['sudo', 'salt', minion, 'state.highstate'], stdout=subprocess.PIPE)
        result, error = output.communicate()

        if error is not None:
            logging.info('ERROR')
            logging.info(error)

        failure = re.search(r'Result:\s+False',result)
        if failure is not None:
            status = 'FAILURE'
        else:
            status = 'OK'
        log.info('\t\t'+state.ljust(20)+minion.ljust(20)+status.ljust(10))


# restoring the original top.sls and cleaning up..
log.info('\t\t==================================================')
log.info('\n\t\tcleaning up...')
cmd = 'sudo mv {0} {1}'.format(path['state']+'/top.sls.bak', path['state']+'/top.sls')
os.system(cmd)
log.info('\t\tsuccessfully executed')
