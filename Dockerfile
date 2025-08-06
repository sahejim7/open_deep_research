# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install uv for fast package management
RUN pip install uv

# --- FIX IS HERE ---
# Copy ALL project files first, including the src directory.
COPY . .

# Now that all files are present, install dependencies.
# This will find the pyproject.toml and the src directory correctly.
RUN uv sync --no-cache

# Let Railway set the port via the $PORT environment variable
EXPOSE 8080

# Define the command to run your app
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "8080"]
