Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonCreateUserAdm {
    param (
        [string]$Text = "Criar Usuario Teste", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonCreateUserAdm = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonCreateUserAdm -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonCreateUserAdm)

    $buttonCreateUserAdm.Add_Click({
        try {
            # Nome do usuário
            $username = "XBOX_TEST"
    
           # Buscar o grupo de administradores dinamicamente usando o SID
             $adminGroup = Get-LocalGroup -SID "S-1-5-32-544"
            
            if (-not $adminGroup) {
                [System.Windows.Forms.MessageBox]::Show("Nao foi possível encontrar o grupo 'Administradores' no sistema.", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
                return
            }
    
            # Criar o usuário sem senha
            $command1 = "New-LocalUser -Name $username -NoPassword -FullName 'XBOX_TEST' -Description 'Conta de Teste com Privilegios Administrativos'"
            Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command1" -Verb RunAs -Wait
    
            # Adicionar o usuário ao grupo de administradores identificado
            addGroupMember -group $adminGroup -user $username
            
            
            
    
            # Exibir mensagem de sucesso
            [System.Windows.Forms.MessageBox]::Show("Usuário $username criado e adicionado ao grupo $adminGroup com sucesso!", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } catch {
            # Exibir mensagem de erro
            [System.Windows.Forms.MessageBox]::Show("Erro ao criar o usuario: $_", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    })

    

    
    return $buttonCreateUserAdm
}

function addGroupMember {
    param (
        [string]$group,
        [string]$user
    )
    $addToGroupCommand = "Add-LocalGroupMember -Group '$group' -Member '$user'"
    Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $addToGroupCommand" -Verb RunAs -Wait
}