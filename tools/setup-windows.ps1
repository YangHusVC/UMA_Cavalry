[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$sourceDirectory = Join-Path $repositoryRoot 'mod\UMA'
$documentsDirectory = [Environment]::GetFolderPath('MyDocuments')
$ck3ModDirectory = Join-Path $documentsDirectory 'Paradox Interactive\Crusader Kings III\mod'
$linkDirectory = Join-Path $ck3ModDirectory 'UMA'
$launcherDescriptor = Join-Path $ck3ModDirectory 'UMA.mod'
$launcherTemplate = Join-Path $repositoryRoot 'launcher\UMA.mod.template'

if (-not (Test-Path -LiteralPath $sourceDirectory -PathType Container)) {
    throw "找不到 MOD 本体目录：$sourceDirectory"
}

New-Item -ItemType Directory -Force -Path $ck3ModDirectory | Out-Null

if (Test-Path -LiteralPath $linkDirectory) {
    $existingItem = Get-Item -LiteralPath $linkDirectory -Force
    if (-not ($existingItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw "目标位置已经存在普通目录，未做覆盖：$linkDirectory"
    }

    Write-Host "目标位置已经是联接，保留现状：$linkDirectory"
}
else {
    New-Item -ItemType Junction -Path $linkDirectory -Target $sourceDirectory | Out-Null
    Write-Host "已创建 MOD 目录联接：$linkDirectory"
}

$portableModPath = $linkDirectory.Replace('\', '/')
$descriptorContent = (Get-Content -LiteralPath $launcherTemplate -Raw).Replace('{{MOD_PATH}}', $portableModPath)
Set-Content -LiteralPath $launcherDescriptor -Value $descriptorContent -Encoding utf8
Write-Host "已生成启动器描述文件：$launcherDescriptor"

