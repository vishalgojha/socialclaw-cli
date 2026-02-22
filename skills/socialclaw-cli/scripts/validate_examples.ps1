param(
    [string]$SkillRoot = "."
)

$ErrorActionPreference = "Stop"

function Assert-Contains {
    param(
        [string]$File,
        [string]$Pattern,
        [string]$Message
    )

    if (-not (Select-String -Path $File -Pattern $Pattern -SimpleMatch -Quiet)) {
        Write-Error $Message
        return $false
    }

    return $true
}

$root = Resolve-Path $SkillRoot
$refs = Join-Path $root "references"

$checks = @(
    @{
        File = Join-Path $refs "command-map.md"
        Pattern = "social instagram accounts list"
        Message = "command-map.md is missing the corrected instagram command example."
    },
    @{
        File = Join-Path $refs "command-map.md"
        Pattern = "social whatsapp phone-numbers list"
        Message = "command-map.md is missing the corrected whatsapp phone-numbers example."
    },
    @{
        File = Join-Path $refs "workflows-core.md"
        Pattern = "social instagram media list --limit 10"
        Message = "workflows-core.md is missing instagram media list example."
    },
    @{
        File = Join-Path $refs "workflows-core.md"
        Pattern = "social instagram insights --ig-media-id <MEDIA_ID> --metric reach,impressions --period day"
        Message = "workflows-core.md is missing required insight flags example."
    },
    @{
        File = Join-Path $refs "workflows-marketing-whatsapp.md"
        Pattern = "social whatsapp phone-numbers list"
        Message = "workflows-marketing-whatsapp.md is missing corrected whatsapp connectivity command."
    }
)

$ok = $true
foreach ($check in $checks) {
    if (-not (Assert-Contains -File $check.File -Pattern $check.Pattern -Message $check.Message)) {
        $ok = $false
    }
}

if (-not $ok) {
    exit 1
}

Write-Output "Example command validation passed."
exit 0
