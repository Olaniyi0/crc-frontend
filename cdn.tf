resource "azurerm_cdn_profile" "resume-cdn-profile" {
  depends_on          = [azurerm_resource_group.resume-group, azurerm_storage_account.resume-storage-account]
  name                = "${local.storage-account-name}-cdn-profile"
  resource_group_name = var.rg-name
  location            = var.rg-location
  sku                 = "Standard_Microsoft"
  tags                = local.common-tags
}

resource "azurerm_cdn_endpoint" "resume-cdn-endpoint" {
  depends_on          = [azurerm_cdn_profile.resume-cdn-profile]
  name                = local.storage-account-name
  profile_name        = azurerm_cdn_profile.resume-cdn-profile.name
  location            = var.rg-location
  resource_group_name = var.rg-name
  origin_host_header  = "${local.storage-account-name}.z6.web.core.windows.net"

  origin {
    name      = local.storage-account-name
    host_name = "${local.storage-account-name}.z6.web.core.windows.net"
  }
}

data "azurerm_dns_zone" "myresumes" {
  name                = "cloudresume.me"
  resource_group_name = "dns-rg"
}

resource "azurerm_dns_cname_record" "myresumes" {
  name                = "www"
  zone_name           = data.azurerm_dns_zone.myresumes.name
  resource_group_name = data.azurerm_dns_zone.myresumes.resource_group_name
  ttl                 = 20
  record              = azurerm_cdn_endpoint.resume-cdn-endpoint.fqdn
}

resource "azurerm_cdn_endpoint_custom_domain" "myresumes" {
  depends_on      = [azurerm_dns_cname_record.myresumes]
  name            = "${local.storage-account-name}-custom-domain"
  cdn_endpoint_id = azurerm_cdn_endpoint.resume-cdn-endpoint.id
  host_name       = "${azurerm_dns_cname_record.myresumes.name}.${data.azurerm_dns_zone.myresumes.name}"
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}
