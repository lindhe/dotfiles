#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# License: MIT
# Author: Andreas Lindhé

""" Main function description.
This is where general documentation should go.
"""

import argparse
import sys


__author__ = "Andreas Lindhé"
__license__ = "MIT"
__version__ = "0.1.0"
description = "Skeleton file for Python!"


def main():
    """ Main function description """
    pass


if __name__ == '__main__':
    # Bootstrapping
    p = argparse.ArgumentParser(description=description)
    # Add cli arguments
    # p.add_argument('-f', '--foo', help="Just a dummmy flag")
    p.add_argument('-V', '--version', action='version', version=__version__)
    # Run:
    args = p.parse_args()
    try:
        main()
    except KeyboardInterrupt:
        sys.exit("\nInterrupted by ^C\n")
