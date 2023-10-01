variable "rg-name" {
  description = "Name of the resource group"
  default     = "crc-frontend"
}

variable "rg-location" {
  description = "Location to store the resource group meta data"
  default     = "westeurope"
}

variable "storage-account-name" {
  description = "Storage account name, it must be unique across Azure"
  default = "monster"
}

variable "dns-cname-record" {
  description = "cname recod e.g www, web, mobile"
  default = "test"
}
