FROM python:3.10.7-slim-buster

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y curl && \
    curl -sSL https://install.python-poetry.org | python -

ENV PATH="/root/.local/bin:$PATH"

COPY ./poetry.lock ./pyproject.toml ./
RUN poetry install

COPY . .

RUN rm -rf Dockerfile ./slides

EXPOSE 8003

ENTRYPOINT ["poetry", "run", "python", "-m", "naucse", "serve", "--host", "0.0.0.0"]
