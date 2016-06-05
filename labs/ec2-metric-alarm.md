# Provisioning Autoscaling group with sereral EC2 instances, ELB, custom ELB healthchecks and an ec2 metric alarm

## Provision an autoscaling group
```
ansible-playbook provision-elb-ec2-metric-alarm-playbook.yml
```

## Verify the instance states in the group
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
```

## Verify the states of the instances towards ELB
```
aws elb describe-instance-health --load-balancer-name workshop-ec2-healthchecks-lb 
```

## Verify the alarms
```
aws cloudwatch describe-alarms --alarm-names cpuDown_workshop-ec2-healthchecks-asg cpuUP_workshop-ec2-healthchecks-asg
```

## Copy stress rpm onto any of the machines
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-ec2-healthchecks-asg --query 'AutoScalingGroups[0].Instances'
aws ec2 describe-instances --instance-ids <instance_id> --query 'Reservations[0].Instances[0].PrivateIpAddress'
scp -i <ssh_key> rpm/stress.rpm <user>@<ip_address>:/tmp/
```

## Ssh to the machine, install stress and run it
```
ssh <user>@<instance_ip_address> -i <path_to_key>
sudo su
rpm -i /tmp/stress.rpm
stress -c 50
```

## Watch the current CPU level and verify that ASG scales up
```
watch uptime
```

## Stop 'watch uptime' and verify that ASG scales down 

# TODO what do those 3 numbers mean?