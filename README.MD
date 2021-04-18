 _Terraform Project Week 4_

 This terraform project will initialize all the resources for the WeightTracker App to be high available with auto scaling for AZURE .


 The project contain 7 Terraform files:

 main.tf:

 main.tf will contain the main set of configuration .

 
 VMs.tf:

 VMs.tf contain VMs deployment information

 
 resource_group.tf:
 
 resource_group.tf will contain the main set of configuration for resource_group.
 
 
 network.tf:
 
 network.tf will contain the network confiuration.
 
 
 LoadBalancer.tf:
 
 LoadBalancer.tf will contain the LoadBalancer confiurations (public).
  
 
 LoadBalancer2.tf:
 
 LoadBalancer2.tf will contain the LoadBalancer confiurations (private).



 LB-rules.tf:
 LB-rules.tf will contain the LoadBalancer additionals rules.




