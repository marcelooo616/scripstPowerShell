Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonReinstalServiceWin {
    param (
        [string]$Text = "Reinstalar Servicos do Windows", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $ButtonReinstalServiceWin = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $ButtonReinstalServiceWin -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($ButtonReinstalServiceWin)

    $ButtonReinstalServiceWin.Add_Click({
        $command = @'
    Get-AppxPackage -AllUsers | ForEach-Object {
        $packageName = $_.Name  
        Try {
            Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -ErrorAction Stop
            Write-Host "Registrado com sucesso: $packageName" -ForegroundColor Green
        }
        Catch {
            Write-Host "Erro ao registrar: $packageName" -ForegroundColor Red
            Write-Host "Motivo do erro: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
'@
    
        # Escapar corretamente o comando para ser passado como argumento
        $escapedCommand = $command -replace '"', '\"'
    
        # Executar o comando em uma nova instância do PowerShell com privilégios administrativos
        Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {$escapedCommand}`"" -Verb RunAs -Wait
        
    })
    


    return $ButtonReinstalServiceWin
}