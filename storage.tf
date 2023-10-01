resource "azurerm_storage_account" "resume-storage-account" {
  depends_on               = [azurerm_resource_group.resume-group]
  name                     = local.storage-account-name
  resource_group_name      = var.rg-name
  location                 = var.rg-location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = local.common-tags

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_blob" "web-files" {
  depends_on             = [azurerm_storage_account.resume-storage-account]
  for_each               = toset(fileset("${path.module}/web-files", "*"))
  name                   = each.key
  storage_account_name   = local.storage-account-name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "./web-files/${each.key}"
  content_type = regex("\\.(.+)$", each.key)[0]

}