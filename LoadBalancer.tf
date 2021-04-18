 
resource "azurerm_lb" "LoadBalancer" {
  name                = "LoadBalancer-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "primary"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_lb_backend_address_pool" "LoadBalancer"{
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.LoadBalancer.id
  name                = "acctestpool"
}
 
resource "azurerm_network_interface_backend_address_pool_association" "nic1_back_association" {
  network_interface_id    = azurerm_network_interface.nic1.id
  ip_configuration_name   = azurerm_network_interface.nic1.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.LoadBalancer.id
  
}
resource "azurerm_network_interface_backend_address_pool_association" "nic2_back_association" {
  network_interface_id    = azurerm_network_interface.nic2.id
  ip_configuration_name   = azurerm_network_interface.nic2.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.LoadBalancer.id
}
 resource "azurerm_network_interface_backend_address_pool_association" "nic3_back_association" {
  network_interface_id    = azurerm_network_interface.nic3.id
  ip_configuration_name   = azurerm_network_interface.nic3.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.LoadBalancer.id
 
}
 
