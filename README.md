Opa is basically a google maps input like location and rego rules like traffic signals and output will be route allowed or not. 
OPA (Open Policy Agent) is a centralized policy decision engine that decouples policy logic from application code by evaluating Rego rules against input data and producing authorization or compliance decisions.

opa eval --format pretty --input tfplan.json --data Policies "data.storage_services"

terraform plan --out=tfplan.binary
terraform show -json tfplan.binary | Out-File -Encoding ascii tfplan.json
opa version
tree /f 
az storage account create --name tfstatebackendss001 --resource-group rg-tfstate --location centralindia --sku Standard_LRS; az storage container create --name tfstate --account-name tfstatebackendss001 
az group create --name rg-tfstate --location centralindia

# to check only provider details
terraform providers
# to check  providers
 Get-Content .terraform.lock.hcl | Select-String 'version'
