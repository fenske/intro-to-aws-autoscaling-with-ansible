# Provisioning Autoscaling group with sereral EC2 instances and ELB

In this lab you will provision an AWS autoscaling group which will create an ELB and 2 EC2 instances with EC2 instances healthchecks

## Provision an autoscaling group

```
ansible-playbook provision-basic-asg-playbook.yml
```

## Verify the group state
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-basic_asg --auto-scaling-group-names workshop-basic_asg --profile <predefined_aws_profile_for_instance> 
```

// TODO Add how to get ip address of ec2 instance by its id
// TODO Add how to get info about ELB 

## Shutting down an instance
```
aws ec2 terminate-instances --instance-ids <ids_of_instanecs> --profile <predefined_aws_profile_for_instance>
```

## Verify the group state
```
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names workshop-basic_asg --profile <predefined_aws_profile_for_instance>
```
// TODO Add how to get ip address of ec2 instance by its id
// TODO Add how to get info about ELB 

// TODO For both instances curl http://<ip_addr>:8080/health
