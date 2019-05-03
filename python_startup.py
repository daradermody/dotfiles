#!/usr/bin/python

"""
Runs every time a python interpreter is started. Set using the PYTHONSTARTUP
environment variable set in the environment_variables file. Conveniently performs
and enmutils init so you don't have to! :D
"""

def main():
    setup_autocomplete()
    setup_persistent_history()


def setup_autocomplete():
    import rlcompleter, readline, os, sys, re
    readline.parse_and_bind('tab:complete')


# General functions
def get_seconds(time_string):
    from datetime import timedelta
    if ':' in time_string:
        time = time_string.split(':')
    else:
        time = re.split('h|m', time_string.rstrip('s'))

    hours, minutes, seconds = [0] * (3 - len(time)) + time
    return (int(hours) * 60 * 60) + (int(minutes) * 60) + float(seconds)


def setup_persistent_history():
    import atexit
    import os
    import readline
    import rlcompleter

    historyPath = os.path.expanduser("~/.pyhistory")

    def save_history(historyPath=historyPath):
        import readline
        readline.write_history_file(historyPath)

    if os.path.exists(historyPath):
        readline.read_history_file(historyPath)

    atexit.register(save_history)
    del atexit, readline, rlcompleter, save_history, historyPath


main()

