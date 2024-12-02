# Provision credentials from environment variables into Windows Credential Manager

# Example: Add database password to Credential Manager
if ($env:DB_PASSWORD) {
    $securePassword = ConvertTo-SecureString $env:DB_PASSWORD -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential("DB_PASSWORD", $securePassword)
    New-StoredCredential -Target "MyApp-DB" -UserName "DB_PASSWORD" -Credential $credential
    Write-Host "Added DB_PASSWORD to Windows Credential Manager."
}

Write-Host "All credentials have been provisioned."
