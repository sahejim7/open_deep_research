# Use a standard Python 3.11 base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install uv for package management
RUN pip install uv

# Copy all project files into the container
COPY . .

# Correctly install all dependencies from pyproject.toml in editable mode
RUN uv pip install -e .

# Expose the port that Railway will use
EXPOSE 8080

# Command to run the production server, pointing to our new main.py file.
# This is the standard, stable way to run the application.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
