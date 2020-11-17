# Terraform Azure Virtual Network
This create a virtual network with 4 subnets and a base security group.

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
