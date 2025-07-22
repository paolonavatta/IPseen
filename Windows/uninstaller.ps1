# IPseen v0.1.0 Uninstaller

# Get the Current Folder
$UninstallerDir = Split-Path -Parent $MyInvocation.MyCommand.Path


# Wrapper File Uninstaller
$WrapperPath = Join-Path $env:SystemRoot "System32\IPseen.cmd"

Write-Host "Removing wrapper file..."
if (Test-Path $WrapperPath) {
    try {
        Remove-Item -Path $WrapperPath -Force
        Write-Host "Wrapper file succesfully deleted."
    }
    catch {
        Write-Warning "Error during wrapper deletion."
    }
}
else {
    Write-Host "Wrapper not found."
}

Write-Host
Write-Host "Removing folder from PATH..."

# PATH Uninstaller
$oldPath = [Environment]::GetEnvironmentVariable("PATH", "User")

if ([string]::IsNullOrEmpty($oldPath)) {
    Write-Host "PATH not defined."
}
else {
    $pathParts = $oldPath -split ';'
    $newPathParts = $pathParts | Where-Object { $_ -ne $UninstallerDir }

    if ($newPathParts.Length -eq $pathParts.Length) {
        Write-Host "Folder not present in PATH."
    }
    else {
        $newPath = [string]::Join(';', $newPathParts)
        [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
        Write-Host "Folder removed from PATH."
    }
}

Pause
