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

## Update the app on the existing instances
ansible-playbook -u cloud-user -i ec2.py --limit tag_aws_autoscaling_groupName_workshop_ec2_healthchecks_asg  provision-to-existing-instances-playbook.yml --extra-vars "app_version=0.0.2" --private-key ~/.ssh/id-shared-key

## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb --profile <aws_profile_name> 
```

## Verify the new functionality
curl http://<ip_addr_of_new_instance>:8080/foo

## TODO Can't reach via ELB
## TODO Make sure instances in different zones 
 

