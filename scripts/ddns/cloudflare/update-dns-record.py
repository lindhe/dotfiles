#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# License: MIT
# Author: Andreas Lindhé

""" Update Cloudflare DNS record
This script helps you to update a DNS recrod that lives on Cloudflare.
"""

import sys
import argparse

def main(hostname: str):
  pass

if __name__ == '__main__':
  # Bootstrapping
  p = argparse.ArgumentParser(description="Updates a DNS record on Cloudflare")
  # Add cli arguments
  p.add_argument('--hostname', help="hostname to update", required=True)
  # Run:
  args = p.parse_args()
  try:
    main(hostname=args.hostname)
  except KeyboardInterrupt:
    sys.exit("\nInterrupted by ^C\n")


