# Create a source bundle
git archive -v -o mlflow.zip --format=zip HEAD

# Create S3 bucket and upload source bundle
aws s3 mb s3://ml-flow-435432815368 --region us-east-1
aws s3 cp mlflow.zip s3://ml-flow-435432815368/

# Create application and environment
aws elasticbeanstalk create-application --application-name ML-Flow
aws elasticbeanstalk create-environment --application-name ML-Flow --environment-name Production --solution-stack-name "64bit Amazon Linux 2018.03 v2.12.16 running Docker 18.06.1-ce"

# Create new application version
aws elasticbeanstalk create-application-version --application-name ML-Flow --version-label v1.0.0 --source-bundle S3Bucket="ml-flow-435432815368",S3Key="mlflow.zip"

# Deploy (update environment to use new application version)
aws elasticbeanstalk update-environment --application-name ML-Flow --environment-name Production --version-label v1.0.0

