output "website-url" {
  value = "${azurerm_dns_cname_record.myresumes.name}.${data.azurerm_dns_zone.myresumes.name}"
}

output "rg-name" {
  value = azurerm_resource_group.resume-group.name
}

output "storage-name" {
  value = azurerm_storage_account.resume-storage-account.name
}

output "cdn-profile-name" {
  value = azurerm_cdn_profile.resume-cdn-profile.name
}