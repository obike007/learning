variable "admin_name" {
    type = string
    description = "Name of Admin User" 
}

variable "vmcount" {
  type = number
  description = "Number of VM instances you wish to provision"
  sensitive = false
  validation {
    condition = max(3, var.vmcount) == 3 
    error_message = "You can only provision a maximum of 3 vms"
  }
}

variable "rg_name" {
    type = string
    description = "Name of Resource Group"
  
}
variable "region" {
  type = string
  description = "Azure Region you want to deploy your web application"
}
variable "vnet_name" {
  type = string
  default = "Name of Virtual Network"
  
}
variable "subnet_name" {
  type = string
  description = "Name of Subnet for Web Application"
  
}