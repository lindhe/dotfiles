#!/bin/python
# monman, the monitor manager
#
# Author: Andreas Lindhé
# Version: 1.0
# License: MIT License

import sys, argparse
from subprocess import run, PIPE
import re

version = "1.0"
verbose = False
sorting = False
# right = True

# def activate(monitors=[]):
#     # Default: activate all connected monitors:
#     if (monitors == "all" or not monitors):
#         monitors = connectedMonitors()
#     # Default: each monitor is "--right-of" the previous
#     direction = " --right-of " if right else " --left-of "
#     config = "xrandr"
#     for i, monitor in enumerate(monitors):
#         config += " --output " + monitor + " --auto"
#         if i:
#             config += direction + monitors[i-1]
#     if verbose: print(config)

def connectedMonitors():
    xrandr = run(["xrandr", "--query"], universal_newlines=True, stdout=PIPE)
    if xrandr.returncode:
        exit(1)
    # Save list of monitor names
    primary = re.compile("(.+) connected primary")
    connected = re.compile("(.+) connected [^primary]")
    pm = primary.findall(xrandr.stdout)
    cm = connected.findall(xrandr.stdout)
    # If sorting is on, sort it. Keep primary at the head.
    cm = pm+sorted(cm) if sorting else pm+cm
    if verbose:
        print("List of connected monitors:")
        print(cm)
    return cm

def checkMonitor(m):
    c = connectedMonitors()
    if verbose:
        if (m in c):
            print(m + " is connected!")
        else:
            print(m + " is not connected!")
    return (m in c)

#################################     Main     #################################
def main():
    global verbose

# Argument parsing
    p = argparse.ArgumentParser(description="Find and activate monitors via xrandr!")

    # p.add_argument('-a', '--activate', metavar="M", nargs="*", default="all",
    #         help="activate all connected monitors specified. Default: \"all\"")

    p.add_argument('-c', '--check', metavar="M",
            help="Check if monitor M is connected")

    # p.add_argument('-d', '--deactivate', metavar="M", nargs="*",
    #         help="deactivate specified monitors. Default: all but primary")

    # p.add_argument('-l', '--left', action="store_true",
    #         help="set every screen --left-of the other")

    # p.add_argument('-r', '--right', action="store_true",
    #         help="set every screen --right-of the other (default)")

    p.add_argument('-s', '--sort', dest="sorting", action="store_true",
            help="sort the list of monitors")

    p.add_argument('-v', '--verbose', action="store_true",
            help="print more stuff")

    p.add_argument('-V', '--version', action="version", version=version)

    args = p.parse_args()
    # right = False if args.left else True
    sorting = args.sorting
    verbose = args.verbose

# Dynamically choose function
    if (args.check):
        if verbose: print("Checking for monitor " + args.check)
        print(checkMonitor(args.check))
    else:
        if verbose: print("Looking for connected monitors...")
        connectedMonitors()

    exit(0)

if __name__ == "__main__":
   main()

exit(1)

