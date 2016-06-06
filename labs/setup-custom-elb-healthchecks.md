# Set up custom healthchecks

In this lab you will set up custom healthchecks for instances in the group.

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

#### SSH to one of the instances
```
ssh <user>@<instance_ip> -i <path_to_key>
```

#### Stop the app container
```
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

#### Verify app state for each instance 
```
curl http://<instance_ip>:8080/ping
```