<#
.SYNOPSIS
    Configure token lifetimes in Microsoft Entra ID using Microsoft Graph PowerShell.

.DESCRIPTION
    This script creates or updates token lifetime policies for access, ID, and SAML tokens.
    Requires Microsoft Graph PowerShell and Policy.ReadWrite.ApplicationConfiguration permissions.

.NOTES
    Author: Oluseun K
    Repository: Entra--Token-Lifetimes
    Date: May 2026
#>

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Policy.ReadWrite.ApplicationConfiguration"

# Define token lifetime policy
$policy = @{
    "definition" = @(
        '{"TokenLifetimePolicy":{"Version":1,"AccessTokenLifetime":"01:00:00","IdTokenLifetime":"01:00:00","SamlTokenLifetime":"01:00:00"}}'
    )
    "displayName" = "StandardTokenLifetimePolicy"
    "isOrganizationDefault" = $false
}

# Create the policy
New-MgPolicyTokenLifetimePolicy -BodyParameter $policy

# Assign policy to an application (replace with your AppId)
$appId = "<Your-App-Id>"
Add-MgApplicationTokenLifetimePolicyByRef -ApplicationId $appId -OdataId "https://graph.microsoft.com/v1.0/policies/tokenLifetimePolicies/<PolicyId>"

Write-Host "Token lifetime policy applied successfully."

