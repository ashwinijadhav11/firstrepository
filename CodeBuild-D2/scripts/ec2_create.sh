#!/bin/bash
set -e

ENVIRONMENT_NAME=$1
VPC_ID=$2
SUBNET_ID=$3

case "$ENVIRONMENT_NAME" in
  "dev")
      EC2_KEY_NAME="amazon-linux-key"
      EC2_INSTANCE_TYPE="t2.micro"
      ;;
  "qa")
      EC2_KEY_NAME="amazon-linux-key"
      EC2_INSTANCE_TYPE="t2.small"
      ;;
  "prod")
      EC2_KEY_NAME="amazon-linux-key"
      EC2_INSTANCE_TYPE="t2.small"
      ;;
esac

EC2_CF_STACK_NAME="${ENVIRONMENT_NAME}-ec2-stack"
EC2_CF_TEMPLATE_FILE="templates/cf_ec2_iam.yml"
ls -alR

echo "ENVIRONMENT_NAME is $ENVIRONMENT_NAME"
echo "VPC_ID is $VPC_ID"
echo "SUBNET_ID is $SUBNET_ID"
echo "EC2_KEY_NAME is $EC2_KEY_NAME"
echo "EC2_INSTANCE_TYPE is $EC2_INSTANCE_TYPE"
echo "EC2_CF_STACK_NAME is $EC2_CF_STACK_NAME"
echo "EC2_CF_TEMPLATE_FILE is $EC2_CF_TEMPLATE_FILE"

echo "Start - CF Deployment of EC2 Resources on $(date +'%Y-%M-%d %T %Z') with Stack Name as ${EC2_CF_STACK_NAME}"

aws cloudformation deploy \
    --region ${AWS_REGION} \
    --stack-name ${EC2_CF_STACK_NAME} \
    --template-file ${EC2_CF_TEMPLATE_FILE} \
    --parameter-overrides \
        KeyName=${EC2_KEY_NAME} \
        InstanceType=${EC2_INSTANCE_TYPE} \
        EnvironmentName=${ENVIRONMENT_NAME} \
        VpcId=${VPC_ID} \
        SubnetId=${SUBNET_ID} \
    --no-fail-on-empty-changeset \
    --capabilities CAPABILITY_NAMED_IAM

echo "Completed - CF Deployment of EC2 Resources on $(date +'%Y-%M-%d %T %Z') with Stack Name as ${EC2_CF_STACK_NAME}"