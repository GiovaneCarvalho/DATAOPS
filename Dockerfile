FROM python::3.11.5-slim-bookworm

RUN pip install poetry

COPY poetry.lock pyproject.toml /code/

COPY ./app.py /app/

