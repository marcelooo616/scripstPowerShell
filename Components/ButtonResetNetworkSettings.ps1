Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonResetNetworkSettings {
    param (
        [string]$Text = "Resetar Rede", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonResetNetworkSettings = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonResetNetworkSettings -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonResetNetworkSettings)

    $buttonResetNetworkSettings.Add_Click({
        try {
            Write-Host "Reiniciando o Winsock..."
            netsh winsock reset
    
            Write-Host "Reiniciando as configurações de IP..."
            netsh int ip reset
    
            Write-Host "Renovando o endereço IP..."
            ipconfig /renew
    
            Write-Host "Limpando o cache DNS..."
            ipconfig /flushdns

            Write-Host "Liberando o endereço IP atual..."
            ipconfig /release

            AdicionarItemChecklist "Resetadas as configurações de rede."
    
            Write-Host "Redefinição das configurações de rede concluída com sucesso!" -ForegroundColor Green

        }
        catch {
            Write-Host "Ocorreu um erro durante a redefinição das configurações de rede: $_" -ForegroundColor Red
        }
    })

    
    

    return $buttonResetNetworkSettings
}