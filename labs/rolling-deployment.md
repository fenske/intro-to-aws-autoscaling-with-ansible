# Rolling deployment

In this lab you will perform rolling deployment for your autoscaling group.

### Helpful commands

#### Get instance IPs
```
aws ec2 describe-instances --instance-ids <instance_id> --query 'Reservations[0].Instances[0].PrivateIpAddress'
```

### Lab

#### Provision a group

```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml
```

#### Verify instance states
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
```

#### Verify ELB state
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb
```

#### Verify that app is working for each instance and ELB
```
curl http://<instance_ip>:8080/ping
curl http://internal-workshop-ec2-healthchecks-lb-265626770.eu-west-1.elb.amazonaws.com/ping
```

#### Verify that new feature doesn't work
```
curl http://internal-workshop-ec2-healthchecks-lb-265626770.eu-west-1.elb.amazonaws.com/foo
```

## Check configuration name
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName'
```

## Provision the group again with an updated configuration
```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml --extra-vars "app_version=0.0.2 lc=new-configuration"
```
//TODO This step needs to be verified

## Check configuration name again
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName'
```

## Update the app on the existing instances
```
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -u <ssh_user> -i ec2.py --limit tag_aws_autoscaling_groupName_workshop_ec2_healthchecks_asg  provision-to-existing-instances-playbook.yml --extra-vars "app_version=0.0.2" --private-key <ssh_key>
```

#### Verify instance states
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
```

#### Verify ELB state
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb
```

#### Verify that app is working for each instance
```
curl http://<instance_ip>:8080/ping
```

#### Verify that new feature works for each instance
```
curl http://<instance_ip>:8080/foo
```

#### SSH to one of the instances
```
ssh <ssh_user>@<instance_ip> -i <path_to_key>
```

#### Stop the app container
```
sudo su
docker stop rest
```

#### Verify instance states
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
```

#### Verify ELB state
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb 
```

#### Verify that app is working for each instance and ELB
```
curl http://<instance_ip>:8080/ping
curl http://internal-workshop-ec2-healthchecks-lb-265626770.eu-west-1.elb.amazonaws.com/ping
```

#### Verify that new feature works for each instance and ELB
```
curl http://<instance_ip>:8080/foo
curl http://internal-workshop-ec2-healthchecks-lb-265626770.eu-west-1.elb.amazonaws.com/foo
```

// TODO How to make sure instances in different zones 
 

