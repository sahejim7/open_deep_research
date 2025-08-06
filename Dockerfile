# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install uv for fast package management
RUN pip install uv

# Copy all project files into the container first
COPY . .

# --- NEW FIX IS HERE ---
# Explicitly add the project's root and src directories to the PYTHONPATH.
# This ensures Python and setuptools can always find your modules.
ENV PYTHONPATH="${PYTHONPATH}:/app:/app/src"

# Now, install all dependencies. It will correctly find the local project.
RUN uv sync --no-cache

# Let Railway set the port via the $PORT environment variable
EXPOSE 8080

# Define the command to run your app
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "8080"]
