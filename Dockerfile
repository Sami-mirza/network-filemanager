# Network File Manager — production image
# Called by: docker compose build / docker build -t netmanager .
# No existing Dockerfile in tree. Reads requirements.txt + netmanager; writes image layers only.
# User: "just do it and also do that docker thing too so people can set it up easily"
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    NETMANAGER_PORT=8080 \
    NETMANAGER_DATA_DIR=/data \
    SECRET_KEY=

WORKDIR /app

RUN useradd --create-home --uid 10001 --shell /usr/sbin/nologin appuser \
    && mkdir -p /data \
    && chown -R appuser:appuser /data \
    && chmod 777 /data

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY netmanager .
RUN chmod +x /app/netmanager && chown appuser:appuser /app/netmanager

USER appuser

EXPOSE 8080

VOLUME ["/data"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD python -c "import os,urllib.request; urllib.request.urlopen('http://127.0.0.1:%s/' % os.environ.get('NETMANAGER_PORT','8080'), timeout=3)"

CMD ["python", "/app/netmanager"]
