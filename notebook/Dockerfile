FROM jupyter/scipy-notebook

RUN conda install \
    'boto3==1.9.*' \
    'mlflow==1.2.*' \
    && \
    pip install awscli --upgrade --user

ENV MLFLOW_TRACKING_URI=http://production.yg2upmxaxt.us-east-1.elasticbeanstalk.com