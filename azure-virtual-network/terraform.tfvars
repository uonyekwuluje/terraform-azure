location = "eastus"
network_name = "dlabs"
network_cidr = ["10.0.0.0/16"]
public_subnets = {
   public1_network = "10.0.0.0/24"
   public2_network = "10.0.1.0/24"
}

private_subnets = {
   private1_network = "10.0.2.0/24"
   private2_network = "10.0.3.0/24"
}

service_endpoints = [ "Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry",
              "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage" ]
