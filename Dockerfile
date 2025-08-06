# Use Python 3.11 as base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install uv for faster package management
RUN pip install uv

# Copy project files
COPY . .

# Install dependencies
RUN uv pip install --system -r pyproject.toml

# Install langgraph-cli
RUN uv pip install --system "langgraph-cli[inmem]"

# Expose the port
EXPOSE $PORT

# Set environment variables
ENV PYTHONPATH=/app

# Command to run the application
CMD uvx --from "langgraph-cli[inmem]" --with-editable . --python 3.11 langgraph dev --host 0.0.0.0 --port $PORT --allow-blocking
