locals {
  db_server_name = "db-tbc-app-services"
}

data "azurerm_resource_group" "existing" {
  name     = var.existing_rg_name
}

data "azurerm_subnet" "private_endpoints" {
  name = var.existing_private_endpoints_subnet_name
  resource_group_name = var.existing_private_endpoints_subnet_rg_name
  virtual_network_name = var.existing_private_endpoints_subnet_vnet_name
}

resource "azurerm_mysql_flexible_server" "main" {
  name                         = local.db_server_name
  resource_group_name          = data.azurerm_resource_group.existing.name
  location                     = data.azurerm_resource_group.existing.location
  administrator_login          = var.mysql_administrator_login
  administrator_password       = var.mysql_administrator_password
  geo_redundant_backup_enabled = true

  identity {
    identity_ids = [var.identity_id,]
    type = "UserAssigned"
  }

  storage {
    auto_grow_enabled = true
    io_scaling_enabled = true
    iops = 360
    log_on_disk_enabled = false
    size_gb = 20
  }
}

# Private endpoint for MySQL
resource "azurerm_private_endpoint" "mysql" {
  name                = "mysql-server-pe"
  location            = azurerm_mysql_flexible_server.main.location
  resource_group_name = azurerm_mysql_flexible_server.main.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoints.id  # Reference your VNet

  private_service_connection {
    name                           = "mysql-psc"
    private_connection_resource_id = azurerm_mysql_flexible_server.main.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
}
