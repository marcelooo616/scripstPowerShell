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
      
        $commandSfc = "sfc /scannow"
        Write-Log "Executando: $commandSfc"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $commandSfc" -Verb RunAs -Wait
        Write-Log "Verificação SFC concluída."
    
 
        $commandDism = "DISM /Online /Cleanup-Image /RestoreHealth"
        Write-Log "Executando: $commandDism"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $commandDism" -Verb RunAs -Wait
        Write-Log "DISM concluído."
    
    
        [System.Windows.Forms.MessageBox]::Show("Verificação e reparo concluídos com sucesso!", "Concluído", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    })

    
    

    return $buttonCheckAndRepair
}