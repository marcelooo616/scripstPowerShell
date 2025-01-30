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
    # Removendo serviços Xbox
    $command = @"
            
            Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage  
            Get-AppxPackage XboxOneSmartGlass | Remove-AppxPackage  
            Get-AppxPackage -allusers Microsoft.XboxGamingOverlay | Remove-AppxPackage  
            Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage  
            Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage  
            Get-AppXPackage *Microsoft.XboxGamingOverlay* -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 

"@

Invoke-Expression $command

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait
    return
}
})

    
    

    return $ButtonReinstalXbox
}