# Rolling deployment

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

## Check the name of the current configuration
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName' --profile <aws_profile_name>
```

## Change autoscaling configuration and provision the autoscaling group again
```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml
```

## Check the name of the current configuration
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName' --profile <aws_profile_name>
```
