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
