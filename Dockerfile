FROM python:3.12-alpine3.19
LABEL maintainer="Sterling De Jesus"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

RUN addgroup -S app && adduser -S app -G app

ARG DEV=false
RUN python3 -m venv /py && \
    /py/bin/pip install --upgrade pip &&  \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp


  
  # RUN chown -R app:app /app

  ENV PATH="/py/bin:$PATH"
  
  # USER app