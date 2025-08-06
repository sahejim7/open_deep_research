# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install uv for fast package management
RUN pip install uv

# Copy the dependency files
COPY pyproject.toml uv.lock ./

# Install project dependencies.
RUN uv sync --no-cache

# Copy the rest of the application code into the container
COPY . .

# Let Railway set the port via the $PORT environment variable
EXPOSE 8080

# Define the command to run your app
# We use --host 0.0.0.0 to make it accessible
# Railway will automatically provide the $PORT variable
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "8080"]
