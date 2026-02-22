param(
    [string]$SkillRoot = ".",
    [string]$Repo = "vishalgojha/social-CLI",
    [string]$Ref = "main"
)

$ErrorActionPreference = "Stop"

function Fail([string]$Message) {
    Write-Error $Message
    exit 1
}

function Get-UpstreamFile([string]$Path) {
    $url = "https://raw.githubusercontent.com/$Repo/$Ref/$Path"
    try {
        return Invoke-RestMethod -Uri $url
    } catch {
        Fail "Failed to fetch upstream file: $url"
    }
}

function Assert-Contains([string]$Text, [string]$Pattern, [string]$Message) {
    if (-not $Text.Contains($Pattern)) {
        Fail $Message
    }
}

function Assert-LocalContains([string]$File, [string]$Pattern, [string]$Message) {
    $content = Get-Content -Path $File -Raw
    if (-not $content.Contains($Pattern)) {
        Fail $Message
    }
}

$root = Resolve-Path $SkillRoot

$instagramJs = Get-UpstreamFile "commands/instagram.js"
$whatsappJs = Get-UpstreamFile "commands/whatsapp.js"
$marketingJs = Get-UpstreamFile "commands/marketing.js"
$opsJs = Get-UpstreamFile "commands/ops.js"

Assert-Contains $instagramJs ".command('accounts')" "Upstream changed: instagram accounts command not found."
Assert-Contains $instagramJs ".command('list')" "Upstream changed: instagram list subcommand not found."
Assert-Contains $instagramJs ".requiredOption('--ig-media-id <id>'" "Upstream changed: instagram insights --ig-media-id flag not found."
Assert-Contains $instagramJs ".requiredOption('--metric <metrics>'" "Upstream changed: instagram insights --metric flag not found."

Assert-Contains $whatsappJs "whatsapp.command('phone-numbers')" "Upstream changed: whatsapp phone-numbers command not found."
Assert-Contains $whatsappJs ".command('send')" "Upstream changed: whatsapp send command not found."
Assert-Contains $whatsappJs ".requiredOption('--to <e164>'" "Upstream changed: whatsapp --to flag not found."

Assert-Contains $marketingJs ".command('status [adAccountId]')" "Upstream changed: marketing status command not found."
Assert-Contains $marketingJs ".command('insights [adAccountId]')" "Upstream changed: marketing insights command not found."

Assert-Contains $opsJs ".command('morning-run')" "Upstream changed: ops morning-run command not found."
Assert-Contains $opsJs ".command('approve <id>')" "Upstream changed: ops approvals approve command not found."

$commandMap = Join-Path $root "references/command-map.md"
$core = Join-Path $root "references/workflows-core.md"
$marketing = Join-Path $root "references/workflows-marketing-whatsapp.md"

Assert-LocalContains $commandMap "social instagram accounts list" "Local command-map.md is missing instagram accounts list example."
Assert-LocalContains $commandMap "social whatsapp phone-numbers list" "Local command-map.md is missing whatsapp phone-numbers list example."
Assert-LocalContains $core "social instagram media list --limit 10" "Local workflows-core.md is missing instagram media list example."
Assert-LocalContains $core "social instagram insights --ig-media-id <MEDIA_ID> --metric reach,impressions --period day" "Local workflows-core.md is missing required instagram insights flags example."
Assert-LocalContains $marketing "social whatsapp phone-numbers list" "Local workflows-marketing-whatsapp.md is missing whatsapp phone-numbers list example."

Write-Output "Upstream contract validation passed."
exit 0
