resource "azurerm_lb_probe" "lb_probe" {
    name = "tcpProbe"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id     = azurerm_lb.LoadBalancer.id
    protocol            = "HTTP"
    port                = 8080
    interval_in_seconds = 5
    number_of_probes    = 2

}



resource "azurerm_lb_probe" "lb_probe_ssh" {
    name = "tcpProbeSsh"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id     = azurerm_lb.LoadBalancer.id
    protocol            = "Tcp"
    port                = 22
    interval_in_seconds = 5
    number_of_probes    = 2

}






resource "azurerm_lb_rule" "LB_rule" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.LoadBalancer.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.LoadBalancer.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.LoadBalancer.id
}




resource "azurerm_lb_rule" "LB_rule2" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.LoadBalancer.id
  name                           = "LBRuleSSH"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.LoadBalancer.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.lb_probe_ssh.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.LoadBalancer.id
}

  
#When using load-balancing rules with Azure Load Balancer, you need to specify health probes to allow Load Balancer to detect the backend endpoint status. 
#The configuration of the health probe and probe responses determine which backend pool instances will receive new flows.
 