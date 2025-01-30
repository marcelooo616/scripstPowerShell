$repoUrl = "https://github.com/marcelooo616/scripstPowerShell/archive/refs/heads/main.zip"
$tempPath = "$env:TEMP\scripstPowerShell.zip"
$extractPath = "$env:TEMP\scripstPowerShell-main"

# Baixar e extrair
Invoke-WebRequest -Uri $repoUrl -OutFile $tempPath
Expand-Archive -Path $tempPath -DestinationPath $env:TEMP -Force

# Rodar o script principal
Set-Location -Path $extractPath
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$extractPath\Main.ps1"
