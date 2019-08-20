# Create a source bundle
zip mlflow.zip Dockerfile requirements.txt

# Create S3 bucket and upload source bundle
aws s3 mb s3://ml-flow-435432815368 --region us-east-1
aws s3 cp mlflow.zip s3://ml-flow-435432815368/

# Create IAM instance profile to allow mlflow server to access S3
aws iam create-role --role-name MLFlow-EC2-Instance-Profile --assume-role-policy-document file://MLFlow-EC2-Trust.json
aws iam put-role-policy --role-name MLFlow-EC2-Instance-Profile --policy-name MLFlow-EC2-Permissions --policy-document file://MLFlow-EC2-Permissions.json
aws iam create-instance-profile --instance-profile-name MLFlow-EC2-Instance-Profile
aws iam add-role-to-instance-profile --instance-profile-name MLFlow-EC2-Instance-Profile --role-name MLFlow-EC2-Instance-Profile

# Create application and environment
aws elasticbeanstalk create-application --application-name ML-Flow
aws elasticbeanstalk create-environment --application-name ML-Flow --environment-name Production --solution-stack-name "64bit Amazon Linux 2018.03 v2.12.16 running Docker 18.06.1-ce" --option-settings file://options.json

# Create new application version
aws elasticbeanstalk create-application-version --application-name ML-Flow --version-label v1.0.0 --source-bundle S3Bucket="ml-flow-435432815368",S3Key="mlflow.zip"

# Deploy (update environment to use new application version)
aws elasticbeanstalk update-environment --application-name ML-Flow --environment-name Production --version-label v1.0.0

