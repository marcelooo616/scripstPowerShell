Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonRepairServiceGames {
    param (
        [string]$Text = "Reparar Servicos de Jogos", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $ButtonRepairServiceGames = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $ButtonRepairServiceGames -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($ButtonRepairServiceGames)

    $ButtonRepairServiceGames.Add_Click({
        Start-Process -FilePath "$scriptPath/GamingRepairTool.exe" -Wait -NoNewWindow
        $global:checklist.Add("Reparados os servicos de jogos do Windows.") | Out-Null
    })
    

    return $ButtonRepairServiceGames
}