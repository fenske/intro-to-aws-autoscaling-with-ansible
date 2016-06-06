# Provision autoscaling group

In this lab you will provision an AWS autoscaling group comprised of an ELB and 2 EC2 instances.

#### Provision a group

```
ansible-playbook provision-basic-asg-playbook.yml
```

#### Shut down one of the instances
```
aws ec2 terminate-instances --instance-ids <instance_id>
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
