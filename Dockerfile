
FROM python:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash appuser
WORKDIR /app


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appuser memory_info.py .
RUN mkdir -p /data && \
    chown -R appuser:appuser /data && \
    chmod +x memory_info.py


VOLUME /data
USER appuser


ENTRYPOINT ["python", "memory_info.py"]