#!/bin/bash


APP="$1"
ENV="$2"
EC2_COUNT="$3"
EC2_SIZE="$4"
TERRAFORM="docker run --rm -v $(pwd):/terraform -it gmitre/terraform"
ISNUMBER='^[0-9]+$'

if [ -z "$APP" ]; then
	echo "Application name not defined"
	echo "usage: cloud-automation.sh <app> <environment> <num_servers> <server_size>"
	exit 2
fi

if [ -z "$ENV" ]; then
	echo "Environment not defined"
	echo "usage: cloud-automation.sh <app> <environment> <num_servers> <server_size>"
	exit 2
fi

if [ -z "$EC2_COUNT" ]; then
	echo "Number of instances not defined"
	echo "usage: cloud-automation.sh <app> <environment> <num_servers> <server_size>"
	exit 2
fi

if ! [[ $EC2_COUNT =~ $ISNUMBER ]]; then
	echo "Number of instances must be a number"
fi

if [ $EC2_COUNT -ge 1 ]; then
	ACTION="apply"
	ACTION_LABEL="Applying"
else
	ACTION="destroy"
	ACTION_LABEL="Destroying"
fi

if [ -z "$EC2_SIZE" ]; then
	echo "Instance size not defined"
	echo "usage: cloud-automation.sh <app> <environment> <num_servers> <server_size>"
	exit 2
fi

CURL="$(which curl)"

if [ -z "$CURL" ]; then
	SSH_CIDR="0.0.0.0/0"
else
	SSH_CIDR="$($CURL -s https://api.ipify.org)/32"
fi

LABEL="guilherme-mitre-$APP-$ENV"

vpc_name="$LABEL-VPC"
igw_name="$LABEL-IGW"
subnet_name="$LABEL-SUBNET"
elb_sg_name="$LABEL-ELB-SG"
elb_sg_desc="ELB Security Group for $LABEL"
instance_sg_name="$LABEL-EC2-SG"
instance_sg_desc="EC2 Security Group for $LABEL"
instance_sg_ssh_cidr="$SSH_CIDR"
elb_name="$LABEL"
ec2_type="$EC2_SIZE"
key_name="$LABEL-KEYPAIR"
ec2_count="\"$EC2_COUNT\""
ec2_name="$LABEL"

echo "$ACTION_LABEL configuration, hang on tight!"
eval "$TERRAFORM $ACTION -var-file=settings.tfvars -var 'vpc_name=$vpc_name' -var 'igw_name=$igw_name' -var 'subnet_name=$subnet_name' -var 'elb_sg_name=$elb_sg_name' -var 'elb_sg_name=$elb_sg_name' -var 'elb_sg_desc=$elb_sg_desc' -var 'instance_sg_name=$instance_sg_name' -var 'instance_sg_desc=$instance_sg_desc' -var 'instance_sg_ssh_cidr=$instance_sg_ssh_cidr' -var 'elb_name=$elb_name' -var 'ec2_type=$ec2_type' -var 'key_name=$key_name' -var 'ec2_count=$ec2_count' -var 'ec2_name=$ec2_name'"
echo "Done!"
if [ "$ACTION" == "apply" ]; then
	echo -n "Your address is: http://"
	eval "$TERRAFORM  output address"
fi
