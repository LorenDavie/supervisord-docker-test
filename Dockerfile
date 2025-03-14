FROM python:3.11

# Set the working directory
WORKDIR /app

# Install supervisord and cron
RUN apt-get update && apt-get install -y supervisor cron && rm -rf /var/lib/apt/lists/*

# Copy the Python script and supervisord config
COPY hello.py /app/hello.py
COPY supervisord.conf /app/supervisord.conf
COPY crontab_hello /app/crontab_hello
RUN chmod 0644 /app/crontab_hello && crontab /app/crontab_hello

# Ensure log files exist
RUN touch /var/log/cron.log /var/log/hello.log

# Set up supervisord to run the script
CMD ["supervisord", "-c", "/app/supervisord.conf"]
