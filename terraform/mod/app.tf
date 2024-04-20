module "web_app" {
  source = "./module" 

  region = "West Europe"
  admin_name = "gideon"
  vmcount = 2
  subnet_name = "websubnet"
  rg_name = "thebulbrg"
  vnet_name = "thebulb-vnet"
  

}

output "public_ip" {
  value = module.web_app.vm_ip
}
