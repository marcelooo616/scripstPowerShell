Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonUpdateDNS {
    param (
        [string]$Text = "Atualizar DNS", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonUpdateDNS = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonUpdateDNS -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonUpdateDNS)

    $buttonUpdateDNS.Add_Click({
        try {
    
            $command = 'Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 8.8.8.8,8.8.4.4'         
            Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait
            [System.Windows.Forms.MessageBox]::Show("DNS alterado com sucesso!", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            AdicionarItemChecklist "Atualizado o DNS do sistema."
        }
        catch {
   
            [System.Windows.Forms.MessageBox]::Show("Erro ao alterar o DNS: $($_.Exception.Message)", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    })

    
    

    return $buttonUpdateDNS
}