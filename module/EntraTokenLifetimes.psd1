@{
    RootModule        = 'EntraTokenLifetimes.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'  # use New-Guid to generate one
    Author            = 'OK'
    CompanyName       = 'Personal'
    Copyright         = '(c) 2026 OK. All rights reserved.'
    Description       = 'PowerShell module for managing Microsoft Entra ID token lifetime policies.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @('Get-EntraTokenLifetimePolicy', 'Set-EntraTokenLifetimePolicy')
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}

