# Provisioning Autoscaling group with sereral EC2 instances and ELB

In this lab you will provision an AWS autoscaling group which will create an ELB and 2 EC2 instances with EC2 instances healthchecks

## Provision an autoscaling group

```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml
```

## Verify the instance states in the group
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances' --profile <aws_profile_name>
```

## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb --profile <aws_profile_name> 
``` 

## Get instance ips
```
aws ec2 describe-instances --instance-ids <instance_id> --profile staging --query 'Reservations[0].Instances[0].PrivateIpAddress'
```

## Ssh to any of the nodes
```
ssh <user>aw@<instance_ip_address> -i <path_to_key>
```

## Stop app container
```
docker stop rest
```

## Verify the instance states in the group
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances' --profile <aws_profile_name>
```

## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb --profile <aws_profile_name>
```

## Verify that app is working
curl http://<ip_addr>:8080/ping