FROM quay.io/astronomer/astro-runtime:10.6.0-python-3.11

USER root
LABEL maintainer="Astronomer"
ARG BUILD_NUMBER=-1
LABEL io.astronomer.docker=true
LABEL io.astronomer.docker.build.number=$BUILD_NUMBER
LABEL io.astronomer.docker.airflow.onbuild=true

ARG TARGET_ENVIRONMENT=local
ENV ENVIRONMENT=$TARGET_ENVIRONMENT

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    ANNOY_COMPILER_ARGS="-D_CRT_SECURE_NO_WARNINGS"

RUN apt-get update && apt-get install -y curl build-essential make

RUN pip install --upgrade pip

RUN pip install uv

COPY pyproject.toml .

RUN uv pip compile pyproject.toml -o requirements.txt

RUN uv pip install --no-cache-dir -r requirements.txt

COPY . .
RUN chown -R astro /usr/local/airflow

USER astro

ENV AIRFLOW__CORE__EXECUTOR=KubernetesExecutor
