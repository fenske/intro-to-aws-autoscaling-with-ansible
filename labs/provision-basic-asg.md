# Provisioning Autoscaling group with sereral EC2 instances and ELB

In this lab you will provision an AWS autoscaling group which will create an ELB and 2 EC2 instances with EC2 instances healthchecks

## Provision an autoscaling group

```
ansible-playbook provision-basic-asg-playbook.yml
```

## Verify the instance states in the group
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
```

## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb
```

## Shutting down an instance
```
aws ec2 terminate-instances --instance-ids <ids_of_instanecs>
```

## Verify the instance states in the group
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
```

## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb
```

## Verify that app is working
curl http://<ip_addr>:8080/ping
