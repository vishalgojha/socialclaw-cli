param(
    [string]$SkillRoot = "."
)

$ErrorActionPreference = "Stop"

function Fail([string]$Message) {
    Write-Error $Message
    exit 1
}

function Assert-File([string]$Path) {
    if (-not (Test-Path $Path -PathType Leaf)) {
        Fail "Missing required file: $Path"
    }
}

$root = Resolve-Path $SkillRoot

$requiredFiles = @(
    (Join-Path $root "SKILL.md"),
    (Join-Path $root "agents/openai.yaml"),
    (Join-Path $root "references/command-map.md"),
    (Join-Path $root "references/workflows-core.md"),
    (Join-Path $root "references/workflows-marketing-whatsapp.md"),
    (Join-Path $root "references/workflows-ops-agent-gateway.md"),
    (Join-Path $root "references/safety-and-risk.md"),
    (Join-Path $root "references/troubleshooting.md")
)

foreach ($file in $requiredFiles) {
    Assert-File $file
}

$skillMdPath = Join-Path $root "SKILL.md"
$skillMd = Get-Content -Path $skillMdPath -Raw

$frontmatterRegex = '(?s)^---\r?\n(.*?)\r?\n---\r?\n'
$frontmatterMatch = [regex]::Match($skillMd, $frontmatterRegex)
if (-not $frontmatterMatch.Success) {
    Fail "SKILL.md frontmatter is missing or malformed."
}

$frontmatter = $frontmatterMatch.Groups[1].Value
if (-not [regex]::IsMatch($frontmatter, '(?m)^name:\s*socialclaw-cli\s*$')) {
    Fail "SKILL.md frontmatter must contain `name: socialclaw-cli`."
}

if (-not [regex]::IsMatch($frontmatter, '(?m)^description:\s*.+$')) {
    Fail "SKILL.md frontmatter must contain a non-empty `description`."
}

if ([regex]::IsMatch($skillMd, '(?i)\bTODO\b')) {
    Fail "SKILL.md still contains TODO placeholders."
}

$body = $skillMd.Substring($frontmatterMatch.Length)
$bodyLineCount = ($body -split "`r?`n").Count
if ($bodyLineCount -gt 500) {
    Fail "SKILL.md body is too long ($bodyLineCount lines). Keep it under 500 lines."
}

$openaiYamlPath = Join-Path $root "agents/openai.yaml"
$openaiYaml = Get-Content -Path $openaiYamlPath -Raw

foreach ($required in @("display_name:", "short_description:", "default_prompt:")) {
    if ($openaiYaml -notmatch [regex]::Escape($required)) {
        Fail "agents/openai.yaml is missing `$required`."
    }
}

Write-Output "Skill CI validation passed."
exit 0
