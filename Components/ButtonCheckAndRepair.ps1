Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonCheckAndRepair {
    param (
        [string]$Text = "Verificar e Reparar", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $ButtonCheckAndRepair = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $ButtonCheckAndRepair -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($ButtonCheckAndRepair)

    $buttonCheckAndRepair.Add_Click({
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
    
            # Executar o comando SFC
            Invoke-AdminCommand -command "sfc /scannow"
    
            # Executar o comando DISM
            Invoke-AdminCommand -command "DISM /Online /Cleanup-Image /RestoreHealth"
    
            # Exibir mensagem de sucesso
            [System.Windows.Forms.MessageBox]::Show(
                "Verificação e reparo concluídos com sucesso!",
                "Concluído",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        } catch {
            # Exibir mensagem de erro em caso de falha
            [System.Windows.Forms.MessageBox]::Show(
                "Erro durante a execução: $_",
                "Erro",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Error
            )
        }
    })

    
    return $buttonCheckAndRepair
}