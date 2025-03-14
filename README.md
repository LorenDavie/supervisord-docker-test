# supervisord-docker-test
test environment for supervisord and docker (fix logging issue)



### Usage

`docker compose up`


Will produce output:

```
hello_container  | Hello world, about to log.
hello_container  | 2025-03-13 16:30:02,307 - /app/./hello.py - INFO - I am logging inside supervisord, inside docker.
hello_container  | I have now logged.
```

... every 5 seconds.


### Fix for log rotation seek error

Look in supervisord.conf:

`stderr_logfile_maxbytes=0`  prevents log rotation (the source of the seek error).


Also note that within the python app, log config is still required, see the basicConfig
lines within hello.py

```python
logging.basicConfig(
    level=logging.DEBUG,  # Set log level to DEBUG
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)],  # Write logs to stdout
)
```


### Adjustments to use cron


The Dockerfile has been modified to install cron, copy in the crontab file and load
it into cron with the `crontab` command.  Also note that it creates the cron log files
via `touch` to ensure they exist before cron is started.

The crontab file "crontab_hello" runs the script once per minute:

```crontab
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# Run hello.py every minute
* * * * * python3 /app/hello.py >> /proc/1/fd/1 2>> /proc/1/fd/2
```

Note the `>> /proc/1/fd/1 2>> /proc/1/fd/2` redirects the cron output to the docker
logs.

