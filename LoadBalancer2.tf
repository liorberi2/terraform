resource "azurerm_lb" "private_LB" {
  name                = "private_LB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "primary"
    subnet_id                     = azurerm_subnet.subnet_private.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.2.10"
  }
}

resource "azurerm_lb_backend_address_pool" "private_LB" {
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.private_LB.id
  name                = "acctestpool"
}

 
resource "azurerm_network_interface_backend_address_pool_association" "nic4_back_association" {
  network_interface_id    = azurerm_network_interface.nic4.id
  ip_configuration_name   = azurerm_network_interface.nic4.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.private_LB.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic5_back_association" {
  network_interface_id    = azurerm_network_interface.nic5.id
  ip_configuration_name   = azurerm_network_interface.nic5.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.private_LB.id
  
}
 resource "azurerm_network_interface_backend_address_pool_association" "nic6_back_association" {
  network_interface_id    = azurerm_network_interface.nic6.id
  ip_configuration_name   = azurerm_network_interface.nic6.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.private_LB.id
 
}
 

