#!/bin/python
# -*- coding: utf-8 -*-
#
# License: MIT
# Author: Andreas Lindhé

import sys

def main():
  print("Main program")
  return (0)

if __name__ == '__main__':
  program = sys.argv[0]

  try:
    main()
  except KeyboardInterrupt:
    sys.stderr.write("Interrupted\n")
    try:
      sys.exit(0)
    except SystemExit:
      sys.exit(1)
