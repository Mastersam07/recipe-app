FROM python:3-alpine
MAINTAINER Mastersam

ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev postgresql-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Setup directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

RUN adduser -D mastersam
USER mastersam