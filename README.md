# Entra ID – Token Lifetimes

![PowerShell](https://img.shields.io/badge/PowerShell-7+-blue)
![License](https://img.shields.io/badge/License-MIT-green)

Guidance, scripts, and examples for configuring token lifetimes in Microsoft Entra ID.

This repository provides:

* A PowerShell module (`EntraTokenLifetimes`) for managing token lifetime policies
* Example scripts for creating and assigning token lifetime policies
* A documentation site published via GitHub Pages
* A deep-dive explanation of token lifetimes in 2026

---

# About the Module

`EntraTokenLifetimes` is a PowerShell module designed to simplify the management of token lifetime policies in Microsoft Entra ID. It provides reusable commands and automation examples for configuring access, ID, and SAML token lifetimes using Microsoft Graph.

---

# Live Documentation Site

[Entra Token Lifetimes Documentation](https://topyo.github.io/Entra--Token-Lifetimes/?utm_source=chatgpt.com)

---

# Requirements

* PowerShell 7+
* Microsoft Graph PowerShell SDK
* Appropriate Microsoft Entra ID administrative permissions
* Access to Microsoft Graph API

---

# Repository Structure

```text id="r7rzwq"
/docs
    index.md
    token-lifetimes.md

/module
    EntraTokenLifetimes.psd1
    EntraTokenLifetimes.psm1

/scripts
    EntraTokenLifetimes.ps1

README.md
```

---

# Installing the PowerShell Module

## Clone the Repository

```bash id="3b8q6i"
git clone https://github.com/topyo/Entra--Token-Lifetimes.git
```

## Import the Module

```powershell id="w22c6x"
Import-Module ./module/EntraTokenLifetimes.psd1
```

---

# Using the Module

## Get All Token Lifetime Policies

```powershell id="zwzbv7"
Get-EntraTokenLifetimePolicy
```

## Set a Custom Token Lifetime for an Application

```powershell id="pmqshn"
Set-EntraTokenLifetimePolicy `
    -AppId "<your-app-id>" `
    -AccessTokenLifetime "01:00:00"
```

---

# Token Lifetimes in Microsoft Entra ID (2026 Update)

Token lifetime policies in Microsoft Entra ID have not disappeared — they have become more specialized.

While Microsoft Entra Conditional Access now governs most session behavior, token lifetimes still play an important role in specific identity and security scenarios.

This guide explains:

* What can still be configured
* What has changed
* Where token lifetime policies still provide value
* Recommended modern practices

---

# What You Can Still Configure

Using Microsoft Graph or Graph PowerShell, you can configure lifetimes for:

* Access tokens
* ID tokens
* SAML tokens

Policies can be assigned at the:

* Tenant level
* Application level
* Service principal level

---

# What You Can No Longer Control

The following settings are no longer managed through token lifetime policies:

* Refresh tokens
* Browser sessions
* Sign-in frequency
* Session persistence

These controls are now handled through:

* Conditional Access → Session Controls

---

# When Token Lifetimes Are Important

Token lifetime policies remain useful as a precision security control for the following scenarios:

## High-Risk Applications

Examples:

* Privileged admin portals
* Sensitive finance applications
* Critical production systems

Goal:

* Reduce exposure if a token is stolen or replayed

---

## Internal Low-Risk Applications

Examples:

* Internal dashboards
* Corporate knowledge portals
* Non-sensitive productivity tools

Goal:

* Reduce reauthentication friction
* Improve user experience

---

## Service-to-Service Workloads

Examples:

* Automation jobs
* APIs
* Background services
* Daemons

Goal:

* Tune automation reliability and operational stability

---

## Compliance-Driven Environments

Examples:

* Financial services
* Healthcare
* Government systems

Goal:

* Enforce strict session duration requirements

---

# Recommended Token Lifetimes

| Scenario                         | Recommended Lifetime | Reason                                        |
| -------------------------------- | -------------------- | --------------------------------------------- |
| High-risk applications           | 10–30 minutes        | Minimizes exposure if a token is compromised  |
| Standard enterprise applications | 60–90 minutes        | Balances usability and security               |
| Low-risk internal tools          | 2–4 hours            | Reduces reauthentication frequency            |
| Service-to-service automation    | 10–60 minutes        | Supports short-lived secure automation tokens |

---

# Example — Create a Token Lifetime Policy

Using Graph PowerShell:

```powershell id="4jsb0y"
$policy = @{
    "definition" = @(
        '{"TokenLifetimePolicy":{"Version":1,"AccessTokenLifetime":"00:30:00"}}'
    )
    "displayName" = "AccessToken_30min"
    "isOrganizationDefault" = $false
}

New-MgPolicyTokenLifetimePolicy -BodyParameter $policy
```

---

# Example — Assign the Policy to an Application

```powershell id="lyq5oh"
$appId = "<service-principal-object-id>"
$policyId = "<policy-id>"

Add-MgServicePrincipalTokenLifetimePolicyByRef `
    -ServicePrincipalId $appId `
    -OdataId "https://graph.microsoft.com/v1.0/policies/tokenLifetimePolicies/$policyId"
```

---

# Token Lifetimes vs Conditional Access

## Use Token Lifetime Policies For

* Access token validity
* ID token validity
* SAML token validity
* Specialized automation scenarios
* Granular governance requirements

---

## Use Conditional Access For

* Sign-in frequency
* Browser session persistence
* Risk-based reauthentication
* Session controls
* Modern Zero Trust enforcement

---

# Best Practices

## Prefer Conditional Access for Session Governance

Microsoft’s modern identity strategy prioritizes:

* Conditional Access
* Continuous Access Evaluation (CAE)
* Risk-based authentication
* Zero Trust controls

Token lifetime policies should complement these controls — not replace them.

---

## Use Short-Lived Tokens for Sensitive Workloads

Short-lived access tokens help reduce:

* Replay attack windows
* Credential theft impact
* Session hijacking exposure

---

## Avoid Excessively Long Token Lifetimes

Long-lived tokens increase risk exposure if:

* Devices are compromised
* Tokens are leaked
* Sessions are intercepted

---

## Test Policies Carefully

Before applying organization-wide policies:

* Validate application compatibility
* Confirm automation workflows
* Test token renewal behavior
* Monitor sign-in logs and failures

---

# Support / Issues

Found a bug or want to request a feature?

* [GitHub Issues – Entra Token Lifetimes](https://github.com/topyo/Entra--Token-Lifetimes/issues?utm_source=chatgpt.com)

---

# Reference Documentation

## Microsoft Learn — Configurable Token Lifetimes

[Microsoft Learn – Configurable Token Lifetimes](https://learn.microsoft.com/en-us/entra/identity-platform/configurable-token-lifetimes?utm_source=chatgpt.com)

---

# Contributing

Contributions, improvements, and suggestions are welcome.

You can contribute by:

* Improving documentation
* Adding automation scripts
* Expanding PowerShell module functionality
* Providing real-world implementation examples

---

# License

This project is provided for educational and operational use.
Review and adapt the scripts to align with your organization’s security and governance requirements.
