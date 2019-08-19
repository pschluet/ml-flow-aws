FROM python:3.6
LABEL maintainer="Paul Schlueter <paul@paulschlueter.com>"

RUN mkdir -p /mlflow/

COPY train.py requirements.txt /mlflow/

WORKDIR /mlflow/

RUN pip install -r requirements.txt

CMD python train.py