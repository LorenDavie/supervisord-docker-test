"""
Hello world.  I live inside supervisord, inside a docker container.
"""

import logging
import sys
import time

log = logging.getLogger(__file__)


def main():
    logging.basicConfig(
        level=logging.DEBUG,  # Set log level to DEBUG
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[logging.StreamHandler(sys.stdout)],  # Write logs to stdout
    )

    while True:
        print("Hello world, about to log.")
        log.info("I am logging inside supervisord, inside docker.")
        print("I have now logged.")
        time.sleep(5)


if __name__ == "__main__":
    main()
