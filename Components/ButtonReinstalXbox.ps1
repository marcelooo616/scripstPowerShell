Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonReinstalXbox {
    param (
        [string]$Text = "Reinstalar Servicos do XBOX", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $ButtonReinstalXbox = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $ButtonReinstalXbox -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($ButtonReinstalXbox)

    $ButtonReinstalXbox.Add_Click({
        try {
            # Função para executar comandos com elevação de privilégios
            function Invoke-AdminCommand {
                param (
                    [string]$command
                )
                Write-Host "Executando: $command"
                Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait
                Write-Host "Comando concluído: $command"
            }
    
            # Função para remover e reinstalar pacotes Xbox
            function Reinstall-XboxPackages {
                # Comandos para remover pacotes Xbox
                $removeCommands = @(
                    "Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage",
                    "Get-AppxPackage XboxOneSmartGlass | Remove-AppxPackage",
                    "Get-AppxPackage -allusers Microsoft.XboxGamingOverlay | Remove-AppxPackage",
                    "Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage",
                    "Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage"
                )
    
                # Executar comandos de remoção
                foreach ($cmd in $removeCommands) {
                    Invoke-AdminCommand -command $cmd
                }
    
                # Reinstalar o pacote Microsoft.XboxGamingOverlay
                $reinstallCommand = @"
                    Get-AppXPackage *Microsoft.XboxGamingOverlay* -AllUsers | Foreach {
                        Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"
                    }
"@
                Invoke-AdminCommand -command $reinstallCommand
            }
    
            # Verificar se o script está sendo executado como administrador
    
            # Executar a função para reinstalar pacotes Xbox
            Reinstall-XboxPackages

            
    
            # Exibir mensagem de sucesso
            [System.Windows.Forms.MessageBox]::Show(
                "Reinstalação dos pacotes Xbox concluída com sucesso!",
                "Concluído",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        } catch {
            # Exibir mensagem de erro em caso de falha
            [System.Windows.Forms.MessageBox]::Show(
                "Erro durante a reinstalação: $_",
                "Erro",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Error
            )
        }
    })
    
    

    return $ButtonReinstalXbox
}