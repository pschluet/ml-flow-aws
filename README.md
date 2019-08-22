# ml-flow-aws
A dockerized version of [MlFlow](https://mlflow.org/) deployed on AWS

## Tracking Server
To deploy the tracking server to AWS elastic beanstalk
```
cd ./tracking-server
./deploy.sh
```
**Note**: The last `update-environment` command will probably fail because it must be run after the environment is already up and running. If it fails, wait until the environment is running (open the AWS Elastic Beanstalk console to check the status), then execute the final command.

## MLFlow Project
### Build
To build the MLFlow Project Docker image locally (this contains the training code)
```
cd ./ml-project
docker build -t poc/ml-project .
```

### Run
To run the training script locally and upload the results to the tracking server
```
docker run -e AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY> -e AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY> poc/ml-project python train.py 0.18
```