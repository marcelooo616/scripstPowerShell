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
        $command = "get-appxpackage Microsoft.GamingServices | remove-AppxPackage -allusers"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait

       
        $command = "start ms-windows-store://pdp/?productid=9MWPM2CQNLHN"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait
    })
    
    

    return $ButtonReinstalServiceGames
}