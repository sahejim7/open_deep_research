# Use Python 3.11 as base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install uv for faster package management
RUN pip install uv

# Copy project files
COPY . .

# Install dependencies into the system, including langgraph-cli and the project itself.
# We KNOW this installation method works from your previous success.
RUN uv pip install --system -e . "langgraph-cli[inmem]"

# Expose the port
EXPOSE 8080

# Command to run the application directly.
# This is simple and will correctly inherit the CORS_ORIGINS variable from Railway.
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "${PORT:-8080}"]
