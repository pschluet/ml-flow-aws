FROM jupyter/scipy-notebook

RUN conda install \
    'boto3==1.9.*' \
    'mlflow==1.2.*' \
    && \
    pip install awscli --upgrade --user

