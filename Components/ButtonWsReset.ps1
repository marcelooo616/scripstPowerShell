Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonWaReset {
    param (
        [string]$Text = "WsReset", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonWsReset = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonWsReset -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonWsReset)

    $buttonWsReset.Add_Click({
        $command = "wsreset.exe"
        Write-Host "Executando: $command"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait 
        AdicionarItemChecklist "Resetada a cache da Microsoft Store usando WsReset." 
        Write-Host "Wsreset concluída."
        
    })

    
    

    return $buttonWsReset
}