resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "myTFVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "westus2"
    resource_group_name = azurerm_resource_group.rg.name
}
# Create subnet
resource "azurerm_subnet" "subnet_public" {
  name                 = "myTFSubnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}  
 
resource "azurerm_subnet" "subnet_private" {
  name                 = "myTFSubnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  
    }


# Create public IP
resource "azurerm_public_ip" "publicip" {
  name                = "myTFPublicIP"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

 
# Create network interface

resource "azurerm_network_interface" "nic1" {
  name                      = "myNIC1"
  location                  = "westus2"
  resource_group_name       = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNICConfg"
    subnet_id                     = azurerm_subnet.subnet_public.id
    private_ip_address_allocation = "dynamic"
   }
    
}
  resource "azurerm_network_interface" "nic2" {
  name                      = "myNIC2"
  location                  = "westus2"
  resource_group_name       = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNICConfg"
    subnet_id                     = azurerm_subnet.subnet_public.id
    private_ip_address_allocation = "dynamic"
   }
  }
  resource "azurerm_network_interface" "nic3" {
  name                      = "myNIC3"
  location                  = "westus2"
  resource_group_name       = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "myNICConfg"
    subnet_id                     = azurerm_subnet.subnet_public.id
    private_ip_address_allocation = "dynamic"
   }
  }
   resource "azurerm_network_interface" "nic4" {
  name                      = "myNIC4"
  location                  = "westus2"
  resource_group_name       = azurerm_resource_group.rg.name
   ip_configuration {
    name                          = "myNICConfg"
    subnet_id                     = azurerm_subnet.subnet_private.id
    private_ip_address_allocation = "dynamic"
   }
  }
  resource "azurerm_network_interface" "nic5" {
  name                      = "myNIC5"
  location                  = "westus2"
  resource_group_name       = azurerm_resource_group.rg.name
   ip_configuration {
    name                          = "myNICConfg"
    subnet_id                     = azurerm_subnet.subnet_private.id
    private_ip_address_allocation = "dynamic"
   }
  }
  resource "azurerm_network_interface" "nic6" {
  name                      = "myNIC6"
  location                  = "westus2"
  resource_group_name       = azurerm_resource_group.rg.name
  
  
  ip_configuration {
    name                          = "myNIC"
    subnet_id                     = azurerm_subnet.subnet_private.id
    private_ip_address_allocation = "dynamic"
   }

   
  }


  resource "azurerm_availability_set" "availability_set1" {
  name                = "public-aset"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name

}

data "azurerm_virtual_network" "data_vnet" {
  name                = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_lb" "data_lb" {
  name                = azurerm_lb.LoadBalancer.name
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_lb_backend_address_pool" "data_pool" {
  name            = azurerm_lb_backend_address_pool.LoadBalancer.name
  loadbalancer_id = data.azurerm_lb.data_lb.id
}


resource "azurerm_availability_set" "availability_set2" {
  name                = "public-aset"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name

}
 

data "azurerm_lb" "data_lb2" {
  name                = azurerm_lb.private_LB.name
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_lb_backend_address_pool" "data_pool2" {
  name            = azurerm_lb_backend_address_pool.private_LB.name
  loadbalancer_id = data.azurerm_lb.data_lb2.id
}



#An availability set is a logical grouping of VMs that allows Azure to understand how your application is built to provide for redundancy and availability. 
#We recommended that two or more VMs are created within an availability set to provide for a highly available application and to meet the 99.95% Azure SLA
