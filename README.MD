OUTLINE

1.
1.1. Spin up n instances, an ELB in front of them
    - Which settings we need to have
        --keypair
        --security groups
        --subnetID // Should be several? How to specify multi AZ?
        --region 
        --keys
        --ami
    
1.2. Demonstrate recovery with default instance healthecks
    -Shut down one of the instances and see what happens
    
1.3. Set up ELB custom healthchecks
    -Shut down one of the containers and see what happens
    -Emphasize which settings are important when configure custom healhchecks (all timeouts)
    
1.4. Rolling update with a different playbook
    -First update ASG with a new ASC then run a playbook with provisioning to the existing instances
    
1.5. Defining a scaling policy and a CPU metric alarm
    - Running load tool on the instance and see what happens
    
    
1.6. Defining your own metric and autoscale based on its values
    

