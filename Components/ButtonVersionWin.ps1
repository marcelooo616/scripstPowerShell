Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonVersionWin {
    param (
        [string]$Text = "Versao do windows", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $ButtonVersionWin = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $ButtonVersionWin -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($ButtonVersionWin)

    $ButtonVersionWin.Add_Click({
        $command = "winver.exe"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" 
       
    })
    

    return $ButtonVersionWin
}