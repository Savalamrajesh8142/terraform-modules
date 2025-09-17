resource "azurerm_resource_group" "base" {
  name     = var.resource_group.name
  location = var.resource_group.location
}
resource "azurerm_virtual_network" "edge" {
  name                = var.vnet_info.name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  address_space       = [var.vnet_info.address_space]


  depends_on = [azurerm_resource_group.base]
}
resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.edge.name
  address_prefixes     = var.subnets[count.index].address_prefixes

  depends_on = [azurerm_virtual_network.edge]
}
