$pwd = Read-Host -AsSecureString "Enter VM admin password"

New-AzResourceGroupDeployment `
  -ResourceGroupName rg-az104-dev-eus `
  -TemplateFile .\09-secure-password.json `
  -vmName "vm-dev-eus-web-01" `
  -adminUsername "linuxadmin" `
  -adminPassword $pwd