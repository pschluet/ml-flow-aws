FROM python:3.6
LABEL maintainer="Paul Schlueter <paul@paulschlueter.com>"

RUN mkdir -p /mlflow/

COPY train.py requirements.txt /mlflow/

WORKDIR /mlflow/

RUN pip install -r requirements.txt

ENV MLFLOW_TRACKING_URI http://production.npxv2cp3ts.us-east-1.elasticbeanstalk.com