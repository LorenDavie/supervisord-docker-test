FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy the Python script and supervisord config
COPY hello.py /app/hello.py
COPY supervisord.conf /app/supervisord.conf

# Install supervisord
RUN apt-get update && apt-get install -y supervisor && rm -rf /var/lib/apt/lists/*

# Set up supervisord to run the script
CMD ["supervisord", "-c", "/app/supervisord.conf"]
