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

## Model Deployment
First, push your model's Docker environment to AWS ECR
```
cd ./ml-project
mlflow sagemaker build-and-push-container -c poc/ml-project
```

TODO: Create a SageMaker Execution Role (AWS IAM Role)

Then deploy your model as an Amazon SageMaker endpoint.
```
mlflow sagemaker deploy \
    -a ML-Flow-POC \
    -m s3://ml-flow-435432815368/0/65b8b0a279a64fec95d4481808164c2c/artifacts/models \
    -i 435432815368.dkr.ecr.us-east-1.amazonaws.com/poc/ml-project:1.2.0 \
    -e arn:aws:iam::435432815368:role/service-role/AmazonSageMaker-ExecutionRole-20190217T114343 \
    --region-name us-east-1 
    -t ml.t2.medium
```

To access the SageMaker endpoint via the AWS boto3 Python client
```
import boto3
import json

client = boto3.client('sagemaker-runtime')
response = client.invoke_endpoint(
        EndpointName='ML-Flow-POC', 
        ContentType='application/json; format=pandas-records', 
        Body='[[2,2],[1,3]]'
    ) 
result = json.loads(response['Body'].read().decode())
print(result)
```
You'll should get `[1, -1]` for the response where a -1 represents an outlier, and a 1 represents an inlier.