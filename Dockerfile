# Use a Python base image (Python 3.11 in this case)
FROM python:3.11-slim

# Set environment variables
ENV POETRY_VERSION=1.5.1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_NO_INTERACTION=1

# Install dependencies needed for Poetry and the application
RUN apt-get update \
    && apt-get install -y curl build-essential \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && rm -rf /var/lib/apt/lists/*

# Add Poetry to PATH
ENV PATH="$POETRY_HOME/bin:$PATH"

# Set the working directory in the container
WORKDIR /app

# Copy pyproject.toml and poetry.lock into the container
COPY pyproject.toml poetry.lock /app/

# Install dependencies without development dependencies (omit --without dev if you want dev dependencies)
RUN poetry install --no-root --no-cache --without dev

# Copy the application code
COPY . /app

# Set the working directory for the application
WORKDIR /app

# Expose the default Streamlit port
EXPOSE 8501

# Specify the entry point for Streamlit
ENTRYPOINT ["streamlit", "run", "app.py"]
