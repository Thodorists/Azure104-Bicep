$pwd = Read-Host -AsSecureString "Enter VM admin password"

New-AzResourceGroupDeployment `
  -ResourceGroupName rg-az104-dev-eus `
  -TemplateFile .\10-parameters-file.json `
  -TemplateParameterFile .\main.parameters.json `
  -adminPassword $pwd