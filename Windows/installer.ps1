# IPseen Installer

# Current Folder Path
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

# PATH Folder Path
$TARGET_DIR = "$env:SystemRoot\System32"

# Wrapper File
$WRAPPER = Join-Path $TARGET_DIR "IPseen.cmd"

$content = @"
@echo off
cd /d "$SCRIPT_DIR"
call IPseen.bat %*
"@

$content | Out-File -FilePath $WRAPPER -Encoding ASCII -Force

pause
