# Rolling deployment

In this lab you will perform rolling deployment for your autoscaling group.

### Helpful commands

#### Get instance IPs
```
aws ec2 describe-instances --instance-ids <instance_id> --query 'Reservations[0].Instances[0].PrivateIpAddress'
```
#### Get ELB hostname
```
aws elb describe-load-balancers --load-balancer-names workshop-elb-custom-checks-lb --query 'LoadBalancerDescriptions[0].DNSName'
```

### Lab

#### Provision a group

```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml
```

#### Verify instance states
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-elb-custom-checks-asg --query 'AutoScalingGroups[0].Instances'
```

#### Verify ELB state
```
aws elb describe-instance-health --load-balancer-name workshop-elb-custom-checks-lb
```

#### Verify that app is working for each instance and ELB
```
curl http://<instance_ip>:8080/ping
curl http://<elb_hostname>/ping
```

#### Verify that new feature doesn't work
```
curl http://<elb_hostname>/foo
```

## Check configuration name
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-elb-custom-checks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName'
```

## Provision the group again with an updated configuration
```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml --extra-vars "app_version=0.0.2 lc=new-configuration"
```

## Check configuration name again
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-elb-custom-checks-asg --query 'AutoScalingGroups[0].LaunchConfigurationName'
```

## Update the app on the existing instances
```
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -u <ssh_user> -i ec2.py --limit tag_aws_autoscaling_groupName_workshop_elb_custom_checks_asg  provision-to-existing-instances-playbook.yml --extra-vars "app_version=0.0.2" --private-key <ssh_key>`
```

#### Verify instance states
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-elb-custom-checks-asg --query 'AutoScalingGroups[0].Instances'
```

#### Verify ELB state
```
aws elb describe-instance-health --load-balancer-name workshop-elb-custom-checks-lb
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
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-elb-custom-checks-asg --query 'AutoScalingGroups[0].Instances'
```

#### Verify ELB state
```
aws elb describe-instance-health --load-balancer-name workshop-elb-custom-checks-lb 
```

#### Verify that app is working for each instance and ELB
```
curl http://<instance_ip>:8080/ping
curl http://<elb_hostname>/ping
```

#### Verify that new feature works for each instance and ELB
```
curl http://<instance_ip>:8080/foo
curl http://<elb_hostname>/foo
```

#### Clean up
```
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml --extra-vars "state=absent" --tags "asg"
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml --extra-vars "state=absent" --tags "lc"
ansible-playbook provision-elb-custom-healthcheks-asg-playbook.yml --extra-vars "state=absent lc=new-configuration" --tags "lc"
``` 

