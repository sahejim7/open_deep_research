# Use a standard Python 3.11 base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install uv for package management
RUN pip install uv

# Copy all project files into the container
COPY . .

# Install all dependencies into the system environment, as required by uv in Docker.
# This is the critical fix for the build error.
RUN uv pip install -e . --system

# Expose the port that Railway will use
EXPOSE 8080

# Command to run the development server, which is now correctly installed.
# This is the command that we know starts the server successfully.
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "${PORT:-8080}"]
