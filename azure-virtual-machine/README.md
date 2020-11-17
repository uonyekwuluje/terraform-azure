# Terraform Azure Virtual Network
This terraform code takes a list of Virtual Machines and Builds them. In order to use this, ensure you have
an existing Virtual Network in place. This code depends on that. For more information, see [Azure Virtual Network](https://github.com/uonyekwuluje/terraform-azure/tree/main/azure-virtual-network)

## Setup
Update **server_names** in ```terraform.tfvars``` with the list of servers you need and apply.

Terraform Initialize
```
terraform init
```

Terraform Plan
```
terraform plan -var="client_id=${APP_ID}" -var="client_secret=${APP_SECRET}"
```

Terraform Apply
```
terraform apply -auto-approve -var="client_id=${APP_ID}" -var="client_secret=${APP_SECRET}"
```

Terraform Destroy
```
terraform destroy -auto-approve -var="client_id=${APP_ID}" -var="client_secret=${APP_SECRET}"
```
