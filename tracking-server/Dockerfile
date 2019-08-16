FROM python:3.6
LABEL maintainer="Paul Schlueter <paul@paulschlueter.com>"

RUN mkdir -p /mlflow/

ADD requirements.txt /mlflow/

WORKDIR /mlflow/

RUN pip install -r requirements.txt

EXPOSE 5000

CMD mlflow server \
  --host 0.0.0.0