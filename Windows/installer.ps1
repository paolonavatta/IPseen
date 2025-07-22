# IPseen v0.1.0 Installer

if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
    Write-Host "curl not found! Please install curl manually."
    exit 1
}

# Current Folder Path
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

# PATH Folder Path
$TARGET_DIR = "$env:SystemRoot\System32"

# Wrapper File
$WRAPPER = Join-Path $TARGET_DIR "IPseen.cmd"

$content = @"
@echo off
call ""$SCRIPT_DIR\IPseen.bat"" %*
"@

$content | Out-File -FilePath $WRAPPER -Encoding ASCII -Force

pause
