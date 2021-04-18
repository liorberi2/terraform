
resource "azurerm_network_security_group" "public" {
  name                = "public"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH1"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

    }
    security_rule {
    name                       = "WEB"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  
   
	  }
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.subnet_public.id
  network_security_group_id = azurerm_network_security_group.public.id
}
 
#Create Network Security Group and rule
resource "azurerm_network_security_group" "private" {
  name                = "private"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Postgres"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
	 
   }
   security_rule {
    name                       = "SSH2"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    
  }
}

 
resource "azurerm_network_interface_security_group_association" "nsg_nic" {
  network_interface_id      = azurerm_network_interface.nic1.id
  network_security_group_id = azurerm_network_security_group.public.id
}



resource "azurerm_network_interface_security_group_association" "nsg_nic2" {
  network_interface_id      = azurerm_network_interface.nic2.id
  network_security_group_id = azurerm_network_security_group.public.id
}


resource "azurerm_network_interface_security_group_association" "nsg_nic3" {
  network_interface_id      = azurerm_network_interface.nic3.id
  network_security_group_id = azurerm_network_security_group.public.id
}
 


 
resource "azurerm_network_interface_security_group_association" "nsg_nic4" {
  network_interface_id      = azurerm_network_interface.nic4.id
  network_security_group_id = azurerm_network_security_group.private.id
}



resource "azurerm_network_interface_security_group_association" "nsg_nic5" {
  network_interface_id      = azurerm_network_interface.nic5.id
  network_security_group_id = azurerm_network_security_group.private.id
}


resource "azurerm_network_interface_security_group_association" "nsg_nic6" {
  network_interface_id      = azurerm_network_interface.nic6.id
  network_security_group_id = azurerm_network_security_group.private.id
}
