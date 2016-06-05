# Rolling deployment

## Provision an autoscaling group

```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml
```

## Verify the instance states in the group
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
```


## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb 
```

## Check the name of the current configuration
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName'
```

## Change autoscaling configuration and provision the autoscaling group again
```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml
```

## Check the name of the current configuration
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName'
```

## Update the app on the existing instances
```
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -u cloud-user -i ec2.py --limit tag_aws_autoscaling_groupName_workshop_ec2_healthchecks_asg  provision-to-existing-instances-playbook.yml --extra-vars "app_version=0.0.2" --private-key <ssh_key>
```

## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb 
```

## Verify the new functionality
curl http://internal-workshop-ec2-healthchecks-lb-265626770.eu-west-1.elb.amazonaws.com/foo

## TODO Make sure instances in different zones 
 

