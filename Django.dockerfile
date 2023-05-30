FROM python:3.9-slim-buster

ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    # dependencies for building Python packages
    && apt-get install -y build-essential \
    # psycopg2 dependencies
    && apt-get install -y libpq-dev \
    # Translations dependencies
    && apt-get install -y gettext \
    # cleaning up unused files
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system django \
    && adduser --system --ingroup django django

# Requirements are installed here to ensure they will be cached.
COPY requirements /requirements
RUN pip install --no-cache-dir -r /requirements/production.txt django-extensions==3.1.5 cyclonedx-bom

COPY --chown=django:django . /app

USER django

# These env vars must be set so that collectstatic can run, but it doesn't actually use it
RUN DATABASE_URL=postgresql://localhost:5432 \
    KEYCLOAK_URL='' \
    KEYCLOAK_REALM='' \
    KEYCLOAK_CLIENT_ID='' \
    CORS_ORIGIN_WHITELIST='' \
    python /app/manage.py collectstatic --noinput \
    && mkdir -p /app/staticfiles/.well-known \
    && cyclonedx-py --requirements --in-file requirements/production.txt --purl-bom-ref --format json --output /app/staticfiles/.well-known/bom

WORKDIR /app

CMD ["/usr/local/bin/gunicorn", "config.wsgi", "--bind", "0.0.0.0:5000", "--chdir=/app", "--error-logfile=-", "--access-logfile=-", "--log-level=debug", "--capture-output", "--enable-stdio-inheritance"]
