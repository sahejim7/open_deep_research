# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install uv for fast package management
RUN pip install uv

# Copy all project files into the container first
COPY . .

# Explicitly add the project's root and src directories to the PYTHONPATH.
ENV PYTHONPATH="${PYTHONPATH}:/app:/app/src"

# Now, install all dependencies.
RUN uv sync --no-cache

# Let Railway set the port via the $PORT environment variable
EXPOSE 8080

# --- FINAL FIX IS HERE ---
# Run the application directly with the production server 'uvicorn'.
# This bypasses the unstable development CLI.
# The path 'open_deep_research.deep_researcher:deep_researcher' points to your main application object.
CMD ["uvicorn", "open_deep_research.deep_researcher:deep_researcher", "--host", "0.0.0.0", "--port", "8080"]
