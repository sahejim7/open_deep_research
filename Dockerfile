# Use a standard Python 3.11 base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install uv for package management
RUN pip install uv

# Copy all project files into the container
COPY . .

# Correctly install all dependencies from pyproject.toml into the system environment.
# This installation command is proven to work.
RUN uv pip install -e . --system "langgraph-cli[inmem]"

# Expose the port that Railway will use
EXPOSE 8080

# Command to run the development server, with the port hardcoded to 8080.
# This avoids all shell variable issues.
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "8080"]
