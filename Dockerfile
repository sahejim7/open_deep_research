# Use a standard Python 3.11 base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install uv for package management
RUN pip install uv

# Copy all project files into the container
COPY . .

# Install all dependencies into the system environment, as required by uv in Docker.
RUN uv pip install -e . --system

# Expose the port that Railway will use
EXPOSE 8080

# Create the startup script that correctly handles environment variables.
# This was your correct solution.
RUN echo '#!/bin/bash\nlanggraph dev --host 0.0.0.0 --port ${PORT:-8080}' > /app/start.sh && chmod +x /app/start.sh

# Command to run the application using the shell script.
CMD ["/app/start.sh"]
