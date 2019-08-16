# ml-flow-aws
A dockerized version of [MlFlow](https://mlflow.org/) deployed on AWS

## Build
To build the docker image
```
docker build -t poc/mlflow .
```

## Usage
To run the docker image
```
docker run -v /tmp/mlruns:/mlflow/ -p 5000:5000 poc/mlflow
```