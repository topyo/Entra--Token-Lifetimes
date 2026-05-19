# Entra--Token-Lifetimes
Guidance, scripts, and examples for configuring token lifetimes in Microsoft Entra ID.
Perfect — since you’re literally editing the **README.md** right now in GitHub (I can see the tab you have open), here is the **exact version** you should paste into Step 2.

This is the polished, GitHub‑ready version of your Token Lifetimes content.

---

# **Token Lifetimes in Microsoft Entra ID (2026 Update)**

Token lifetime policies in Microsoft Entra ID haven’t disappeared — they’ve simply become more specialized. While Conditional Access now governs most session behavior, token lifetimes still play an important role in specific scenarios.

This document summarizes what’s still configurable, what has changed, and when token lifetimes matter in modern identity governance.

---

## What You Can Still Configure

Using **Microsoft Graph** or **Graph PowerShell**, you can define lifetimes for:

- **Access tokens**  
- **ID tokens**  
- **SAML tokens**

These policies can be applied at the **tenant**, **application**, or **service principal** level.

---

##  What You Can No Longer Control

The following are *not* configurable via token lifetime policies:

- Refresh tokens  
- Browser sessions  
- Sign‑in frequency  
- Session persistence  

These are now governed by **Conditional Access → Session Controls**.

---

##  When Token Lifetimes is Crucial

Token lifetimes remain a precision tool for:

- **High‑risk apps** → minimize exposure if a token is stolen  
- **Internal low‑risk apps** → reduce reauthentication friction  
- **Service‑to‑service workloads** → tune automation stability  
- **Compliance‑driven environments** → enforce strict session windows  

---

## 📏 Recommended Token Lifetimes

| Scenario | Recommended Lifetime | Why |
|---------|----------------------|------|
| **High‑risk apps** (privileged access, admin portals) | **10–30 minutes** | Minimizes exposure if a token is compromised |
| **Standard enterprise apps** | **60–90 minutes (default)** | Balanced UX + security |
| **Low‑risk internal tools** | **2–4 hours** | Reduces reauthentication friction |
| **Service‑to‑service automation** | **10–60 minutes** | Short tokens + automated refresh |

---

##  Example: Creating a Token Lifetime Policy (Graph PowerShell)

```powershell
# Example: Create a 30-minute access token lifetime policy
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

##  Assigning the Policy to an App

```powershell
# Assign policy to a service principal
$appId = "<service-principal-object-id>"
$policyId = "<policy-id>"

Add-MgServicePrincipalTokenLifetimePolicyByRef `
    -ServicePrincipalId $appId `
    -OdataId "https://graph.microsoft.com/v1.0/policies/tokenLifetimePolicies/$policyId"
```

---

## Token Lifetimes vs Conditional Access

Use **token lifetime policies** for:  
✔ Access/ID/SAML token validity  
✔ Automation scenarios  
✔ Specialized governance requirements  

Use **Conditional Access** for:  
✔ Sign‑in frequency  
✔ Session persistence  
✔ Browser session control  
✔ Risk‑based reauthentication  

---

## 📚 Reference

Microsoft Learn — Configurable Token Lifetimes  
[https://learn.microsoft.com/en-us/entra/identity-platform/configurable-token-lifetimes](https://learn.microsoft.com/en-us/entra/identity-platform/configurable-token-lifetimes)

---

