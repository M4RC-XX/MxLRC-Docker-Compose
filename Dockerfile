# Dockerfile for mxlrc on the Raspberry Pi ARM64

# 1. Select base image
# We are using a slim Python image suitable for the ARM64 architecture of the Raspberry Pi 5.
FROM python:3.11-slim

# 2. Set the working directory in the container
# All subsequent commands will be executed in this directory.
WORKDIR /app

# 3. Install required Python packages
# First, we copy the requirements.txt and then install the dependencies.
# --no-cache-dir reduces the size of the final image.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy application files
# We copy the main script and the entrypoint script into the working directory.
COPY mxlrc.py .
COPY entrypoint.sh .

# 5. Make the entrypoint script executable
RUN chmod +x entrypoint.sh

# 6. Configure the container to run our script on startup
ENTRYPOINT ["./entrypoint.sh"]
