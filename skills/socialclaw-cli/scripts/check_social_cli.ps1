param(
    [string]$MinVersion = "0.2.13"
)

function Parse-Version {
    param([string]$Text)
    try {
        return [Version]$Text.Trim()
    } catch {
        return $null
    }
}

$cmd = Get-Command social -ErrorAction SilentlyContinue
if (-not $cmd) {
    Write-Error "social CLI not found in PATH. Install with: npm install -g @vishalgojha/social-cli"
    exit 2
}

$rawVersion = & social --version 2>$null
if (-not $rawVersion) {
    Write-Error "social CLI was found but version check failed."
    exit 3
}

if ($rawVersion -match "([0-9]+\.[0-9]+\.[0-9]+)") {
    $detected = $Matches[1]
} else {
    $detected = $rawVersion.Trim()
}

$detectedVersion = Parse-Version -Text $detected
$minimumVersion = Parse-Version -Text $MinVersion

if (-not $detectedVersion -or -not $minimumVersion) {
    Write-Output "social CLI detected (raw version: $rawVersion)"
    exit 0
}

if ($detectedVersion -lt $minimumVersion) {
    Write-Error "social CLI version $detected is older than required $MinVersion. Upgrade with: npm install -g @vishalgojha/social-cli"
    exit 4
}

Write-Output "social CLI ready (version $detected)."
exit 0
