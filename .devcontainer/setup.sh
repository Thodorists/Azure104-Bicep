#!/usr/bin/env bash

set -e

echo "Installing Azure Bicep..."

az bicep install

echo "Installing Az PowerShell module..."

pwsh -NoProfile -Command '
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber
'

echo "Verifying installation..."

echo "Azure CLI:"
az version

echo "Terraform:"
terraform version

echo "PowerShell:"
pwsh --version

echo "Az PowerShell:"
pwsh -NoProfile -Command 'Get-Module Az -ListAvailable | Select-Object Name, Version'

echo "Bicep:"
az bicep version

echo "======================================"
echo "Azure 104 environment is ready!"
echo "======================================"
