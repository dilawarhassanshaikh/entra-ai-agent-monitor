# Entra AI Agent Monitor (v0.1)
# Generates a sample report (no Graph calls yet)

. $PSScriptRoot\..\src\reporting\New-AIHtmlReport.ps1

$sample = [pscustomobject]@{
  tenant    = "contoso.onmicrosoft.com"
  generated = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  apps      = @(
    [pscustomobject]@{
      name               = "ChatGPT Enterprise Plugin"
      appId              = "f9c1234-xxxx"
      owners             = "None"
      permissions        = @("Mail.Read", "Files.Read.All")
      risk               = "High"
      created            = "2025-11-12"
      consentType        = "User Consent"
      lastSignIn         = "2026-01-11"
      signIns30d         = 428
      conditionalAccess  = "Not Applied"
    },
    [pscustomobject]@{
      name               = "Slack AI Bot"
      appId              = "e83b29f-xxxx"
      owners             = "security@contoso.com"
      permissions        = @("User.Read")
      risk               = "Low"
      created            = "2025-10-03"
      consentType        = "Admin Consent"
      lastSignIn         = "2026-01-10"
      signIns30d         = 95
      conditionalAccess  = "Applied"
    }
  )
}

$outHtml = Join-Path $PSScriptRoot "..\out\ai-agent-monitor.html"
$outJson = Join-Path $PSScriptRoot "..\out\ai-agent-monitor.json"

# Save JSON
$sample | ConvertTo-Json -Depth 10 | Set-Content -Path $outJson -Encoding UTF8

# Save HTML
New-AIHtmlReport -Data $sample -OutPath $outHtml

Write-Host "Report generated:" -ForegroundColor Green
Write-Host " - $outHtml"
Write-Host " - $outJson"
