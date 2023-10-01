output "website-url" {
  value = "${azurerm_dns_cname_record.myresumes.name}.${data.azurerm_dns_zone.myresumes.name}"
}