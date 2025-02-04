Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonReinstalServiceGames {
    param (
        [string]$Text = "Reinstalar Servico de Jogos", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $ButtonReinstalServiceGames = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $ButtonReinstalServiceGames -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($ButtonReinstalServiceGames)

    $ButtonReinstalServiceGames.Add_Click({
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
    
            # Remover o pacote do Microsoft.GamingServices para todos os usuários
            Invoke-AdminCommand -command "get-appxpackage Microsoft.GamingServices | remove-AppxPackage -allusers"
    
            # Abrir a Microsoft Store na página de instalação do Microsoft.GamingServices
            Invoke-AdminCommand -command "start ms-windows-store://pdp/?productid=9MWPM2CQNLHN"

            AdicionarItemChecklist "Reinstalados os servicos de jogos."
    
            # Exibir mensagem de sucesso
            [System.Windows.Forms.MessageBox]::Show(
                "Reinstalação do Microsoft.GamingServices concluída com sucesso!",
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
    
    

    return $ButtonReinstalServiceGames
}