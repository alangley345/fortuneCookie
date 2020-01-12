
#Fortune Cookie Web App and Site to learn AWS
=====================

1. Started out with static html over the default index.html on a manually provisioned aws t2.micro instance.
2. Created a terraform config to automatically deploy aws instance on EC2, then manually installed nginxi and updated website content.
3. Turned nginix / website deploy into a packer-built ami using shell script and reconfigured terraform to use this instance.
4. Redeployed site using packer to call ansible, having ansible configure packer build using a playbook.
5. Reconfigured .tf file to include autoscaling groups and created a .tf file for the load balancer. Configured the loadbalancer file to create load balancer with HTTP listener that redirects to HTTPS and HTTPS that redirects to instances of fortunecookie.greatcat.net. Removed external IP associated with instances in the target group. 

