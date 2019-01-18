#!/usr/bin/python3
# -*- coding: utf-8 -*-
# vim: syntax=python
# License: Stolen from https://support.loopia.se/wiki/uppdatera-dynamisk-ip-adress-med-loopiaapi/

"""
########### HOW TO USE THIS FILE ###########{{{

A few rows down are several variables that you have to change.
Remember to NOT use your Customer Zone credentials, but your LoopiaAPI credentials.

If you don't have an API user yet you can create one in the Customer Zone.
For reasons of security you shouldn't add more permissions than necessary.

The user requires the following permissions for this script to function:
* getZoneRecords    - To find out which record to update
* updateZoneRecord  - To actually update the zone record

The following permissions are optional but recommended:
* removeZoneRecord  - If the zone has several A-records, this is necessary to remove all excess records.
* addZoneRecord     - Necessary if the zone doesn't have any A-record at all.

This script requires Python 3.0 or later.
Any versions earlier than Python 3.0 WILL fail.

On Linux, Mac OS and other Unix based systems you can use "cron"
to schedule this script to make sure your IP address is updated automatically.
On Windows you can use the "Task Scheduler".

Please contact support@loopia.se if you have any questions./*}}}*/
"""

import sys
import xmlrpc.client
import urllib.request
import re
from urllib.error import URLError

class Config:
    ########## EDIT HERE ##########
    # Your LoopiaAPI user credentials
    # Make sure to change these!
    # Remember, these are NOT the same as your credentials for the Loopia Customer Zone.
    username = 'youruser@loopiaapi'
    password = 'thesecretpasswordforexample.com'

    # Which domain name do you wish to update?
    # Omit any subdomains here (i.e only write "mindoman.se", not "www.mindoman.se").
    domain = 'example.com'

    # Which subdomain do you wish to update? Use "@" if you wish to update the root domain.
    subdomain = '@'

    # Time To Live value. You don't actually have to change this at all unless
    # you have a very specific reason for wanting a different value.
    # This value is only used when creating new A records, not when modifying existing.
    ttl = '300'

    # All right, you're all set. No need to change anything else!

    # Hint!
    # If you wish to change the IP address for the main subdomains ("@", "www" and "*")
    # you only need to keep "@" updated.
    # Point the other subdomains to the main domain with CNAME records.

    ######### STOP EDITING HERE #########

def api_error():
    """Print a warning message because an error has occured"""

    print('Error! Not sure why, sorry! Please check your internet connection and http://www.driftbloggen.se. Contact support@loopia.se if the problem persists.')
    sys.exit(1)

def del_excess(Config, zone_records):
    """Remove all A records except the first one"""

    num = 0
    for record in zone_records:
        client.removeZoneRecord(
                Config.username,
                Config.password,
                Config.domain,
                Config.subdomain,
                record['record_id'])
        num = num + 1

    print('Deleted {} unnecessary record(s)'.format(str(num)))

def get_ip():
    """Get public IP adress"""
    try:
        result = urllib.request.urlopen('http://dns.loopia.se/checkip/checkip.php').read()
        return re.search('[0-9.]+', str(result)).group(0) # Very sloppy regex, but it gets the job done.
    except URLError  as e:
        print("Could not find public IP address.")
        print("Reason: ", e.reason)

def get_records(Config):
    """Get current zone records"""
    try:
        zone_records = client.getZoneRecords(
            Config.username,
            Config.password,
            Config.domain,
            Config.subdomain)
        if 'AUTH_ERROR' in zone_records:
            print('Your user information seems to be incorrect. Please edit this file and check your username and password.')
            sys.exit(2)
        if 'UNKNOWN_ERROR' in zone_records:
            print('API returned "UNKNOWN ERROR". This could mean that the requested (sub)domain does not exist in this account.')
            sys.exit(3)
        # No error found. Remove irrelevant records and return.
        return [d for d in zone_records if d['type'] == 'A']
    except:
        # Can't connect to the API for other reasons
        api_error()


def add_record(Config, ip):
    """Add a new A record if we don't have any"""

    new_record = {
        'priority': '',
        'rdata': ip,
        'type': 'A',
        'ttl': ttl
    }

    status = client.addZoneRecord(
            Config.username,
            Config.password,
            Config.domain,
            Config.subdomain,
            Config.new_record)

    if Config.subdomain == '@':
        print('{domain}: {status}. Added new record.'.format(
            domain=Config.domain,
            status=status))
    else:
        print('{subdomain}.{domain}: {status}. Added new record.'.format(
            subdomain=Config.subdomain,
            domain=Config.domain,
            status=status))

def update_record(Config, ip, record):
    """Update current A record"""

    # Does the record need updating?
    if record['rdata'] != new_ip:
        # Yes it does. Update it!
        new_record = {
            'priority': record['priority'],
            'record_id': record['record_id'],
            'rdata': new_ip,
            'type': record['type'],
            'ttl': record['ttl']
        }

        try:
            status = client.updateZoneRecord(
                    Config.username,
                    Config.password,
                    Config.domain,
                    Config.subdomain,
                    new_record)

            if Config.subdomain == '@':
                print('{domain}: {status}'.format(
                    domain=Config.domain,
                    status=status))
            else:
                print('{subdomain}.{domain}: {status}'.format(
                    subdomain=Config.subdomain,
                    domain=Config.domain,
                    status=status))

        except:
            api_error()

    else:
        # Record does not need updating
        if Config.subdomain == '@':
            print('{domain}: No change'.format(domain=Config.domain))
        else:
            print('{subdomain}.{domain}: No change'.format(
                subdomain=Config.subdomain,
                domain=Config.domain))


############
### Main ###
############

if __name__ == '__main__':
    # Build XML RPC client
    client = xmlrpc.client.ServerProxy(
        uri = 'https://api.loopia.se/RPCSERV',
        encoding = 'utf-8')

    # Get current A records and public IP address
    a_records = get_records(Config)
    new_ip = get_ip()

    # Do we currently have an A record? If not, create one!
    if len(a_records) == 0:
        add_record(Config, new_ip)

    else:
        # Remove all excess A records
        if len(a_records) > 1:
            del_excess(Config, a_records[1:])

        # Now let's update the record!
        update_record(Config, new_ip, a_records [0])
