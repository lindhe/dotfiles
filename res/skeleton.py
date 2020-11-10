#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# License: MIT
# Author: Andreas Lindhé

""" Main function description.
This is where general documentation should go.
"""

import sys
import argparse


def main():
    """ Main function description """
    pass


if __name__ == '__main__':
    # Bootstrapping
    p = argparse.ArgumentParser(description="Skeleton file for Python!")
    # Add cli arguments
    # p.add_argument('-f', '--foo', help="Just a dummmy flag")
    # Run:
    args = p.parse_args()
    try:
        main()
    except KeyboardInterrupt:
        sys.exit("\nInterrupted by ^C\n")
