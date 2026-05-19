function Set-EntraTokenLifetimePolicy {
    param(
        [string]$AppId,
        [timespan]$AccessTokenLifetime = "01:00:00"
    )

    # Connect to Microsoft Graph
    Connect-MgGraph -Scopes "Policy.ReadWrite.ApplicationConfiguration"

    # Define token lifetime policy
    $policy = @{
        "definition" = @(
            ('{"TokenLifetimePolicy":{"Version":1,"AccessTokenLifetime":"{0}"}}' -f $AccessTokenLifetime)
        )
        "displayName" = "CustomTokenLifetimePolicy"
        "isOrganizationDefault" = $false
    }

    # Create the policy
    $newPolicy = New-MgPolicyTokenLifetimePolicy -BodyParameter $policy

    # Assign policy to the specified app
    Add-MgApplicationTokenLifetimePolicyByRef -ApplicationId $AppId -OdataId "https://graph.microsoft.com/v1.0/policies/tokenLifetimePolicies/$($newPolicy.Id)"

    Write-Host "Token lifetime policy applied successfully to AppId: $AppId"
}


