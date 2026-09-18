# AZ-104 Codespace setup

Write-Host "Checking Azure CLI..." -ForegroundColor Cyan
az version

Write-Host "Checking Bicep..." -ForegroundColor Cyan
az bicep version

Write-Host "Installing Azure PowerShell (Az)..." -ForegroundColor Cyan
Install-Module Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber

Write-Host "Checking Azure PowerShell..." -ForegroundColor Cyan
Get-Module Az -ListAvailable | Select-Object Name, Version

Write-Host "Checking Git..." -ForegroundColor Cyan
git --version

Write-Host ""
Write-Host "AZ-104 environment ready!" -ForegroundColor Green
