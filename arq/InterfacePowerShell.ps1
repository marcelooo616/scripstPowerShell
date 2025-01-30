# Adiciona o módulo Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Função para reiniciar o PowerShell com privilégios elevados
function Run-AsAdmin {
    if (-NOT [System.Security.Principal.WindowsIdentity]::GetCurrent().IsElevated) {
        $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
        Start-Process powershell -ArgumentList $arguments -Verb RunAs
        Exit
    }
}

# Criação do formulário
$form = New-Object System.Windows.Forms.Form
$form.Text = "Gestor de Tarefas"
$form.Size = New-Object System.Drawing.Size(800, 700)
$form.BackColor = [System.Drawing.Color]::FromArgb(12, 12, 12) # Fundo escuro estilo PowerShell
$form.ForeColor = [System.Drawing.Color]::White # Texto branco
$form.Font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Regular) # Fonte PowerShell padrão
$form.StartPosition = "CenterScreen"




# Criação do botão para verificação de ficheiros corrompidos
$buttonCheck = New-Object System.Windows.Forms.Button
$buttonCheck.Text = "Verificar e Reparar"
$buttonCheck.Size = New-Object System.Drawing.Size(250, 40)
$buttonCheck.Location = New-Object System.Drawing.Point(125, 50)
$buttonCheck.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Azul PowerShell
$buttonCheck.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonCheck)

# Criação do botão para reimplementar a imagem do Windows
$buttonDism = New-Object System.Windows.Forms.Button
$buttonDism.Text = "Reimplementar a imagem do Windows"
$buttonDism.Size = New-Object System.Drawing.Size(250, 40)
$buttonDism.Location = New-Object System.Drawing.Point(125, 100)
$buttonDism.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Azul PowerShell
$buttonDism.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonDism)

# Criação do botão para reinstalar serviços do Xbox
$buttonReinstall = New-Object System.Windows.Forms.Button
$buttonReinstall.Text = "Reinstalar serviços Xbox"
$buttonReinstall.Size = New-Object System.Drawing.Size(250, 40)
$buttonReinstall.Location = New-Object System.Drawing.Point(125, 150)
$buttonReinstall.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Azul PowerShell
$buttonReinstall.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonReinstall)

# Criação do botão para alterar DNS
$buttonAlterarDsn = New-Object System.Windows.Forms.Button
$buttonAlterarDsn.Text = "Alterar DNS"
$buttonAlterarDsn.Size = New-Object System.Drawing.Size(250, 40)
$buttonAlterarDsn.Location = New-Object System.Drawing.Point(125, 200)
$buttonAlterarDsn.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Azul PowerShell
$buttonAlterarDsn.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonAlterarDsn)

# Criação do botão para Criar usuario teste
$buttonCriarUsuario = New-Object System.Windows.Forms.Button
$buttonCriarUsuario.Text = "Criar Usuario Teste"
$buttonCriarUsuario.Size = New-Object System.Drawing.Size(250, 40)
$buttonCriarUsuario.Location = New-Object System.Drawing.Point(125, 250)
$buttonCriarUsuario.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Azul PowerShell
$buttonCriarUsuario.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonCriarUsuario)

# Criação do TextBox para exibir logs
$logBox = New-Object System.Windows.Forms.TextBox
$logBox.Multiline = $true
$logBox.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$logBox.Location = New-Object System.Drawing.Point(50, 290)
$logBox.Size = New-Object System.Drawing.Size(400, 80)
$logBox.BackColor = [System.Drawing.Color]::FromArgb(12, 12, 12)
$logBox.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($logBox)

# Função para escrever logs no TextBox
function Write-Log {
    param ($message)
    $logBox.AppendText("$message`r`n")
    $logBox.SelectionStart = $logBox.Text.Length
    $logBox.ScrollToCaret()
}

# Função para executar os comandos com progresso
function Execute-Command {
    param (
        [string]$command,
        [string]$statusMessage
    )
    
    Write-Log "$statusMessage..."
    $statusLabel.Text = $statusMessage
    $progressBar.Value = 0
    
    $processInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processInfo.FileName = "powershell.exe"
    $processInfo.Arguments = "-Command `"$command`""
    $processInfo.Verb = "RunAs"
    $processInfo.RedirectStandardOutput = $true
    $processInfo.UseShellExecute = $false
    $processInfo.CreateNoWindow = $true

    $process = [System.Diagnostics.Process]::Start($processInfo)
    
    $output = $process.StandardOutput.ReadToEnd()
    $process.WaitForExit()
    
    foreach ($line in $output) {
        Write-Log $line
    }
}

$buttonCheck.Add_Click({
    $command = "sfc /scannow"
    Write-Log "Executando: $command"
    Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait 
    Write-Log "Verificação concluída."
})

$buttonAlterarDsn.Add_Click({
    try {
        $command = "Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 8.8.8.8,1.1.1.1"
        Write-Log "Executando: $command"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait  
        [System.Windows.Forms.MessageBox]::Show("DNS alterado com sucesso!", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Erro ao alterar o DNS: $_", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
  

})


$buttonDism.Add_Click({
    $command = "DISM /Online /Cleanup-Image /Restorehealth"
    Write-Log "Executando: $command"
    Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait
    Write-Log "DISM concluído."
})

# Função para criar um usuário administrador de teste
$buttonCriarUsuario.Add_Click({
    try {
        # Nome do usuário
        $username = "TesteAdmin"

        # Buscar o grupo de administradores dinamicamente (exatamente "Administradores")
        $adminGroup = (Get-LocalGroup | Where-Object { $_.Name -eq "Administradores" }).Name
        
        if (-not $adminGroup) {
            [System.Windows.Forms.MessageBox]::Show("Não foi possível encontrar o grupo 'Administradores' no sistema.", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            return
        }

        # Criar o usuário sem senha
        $command1 = "New-LocalUser -Name $username -NoPassword -FullName 'Usuário de Teste' -Description 'Conta de Teste com Privilégios Administrativos'"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command1" -Verb RunAs -Wait

        # Adicionar o usuário ao grupo de administradores identificado
        addGroupMember -group $adminGroup -user $username

        # Exibir mensagem de sucesso
        [System.Windows.Forms.MessageBox]::Show("Usuário $username criado e adicionado ao grupo $adminGroup com sucesso!", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    } catch {
        # Exibir mensagem de erro
        [System.Windows.Forms.MessageBox]::Show("Erro ao criar o usuário: $_", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Função para adicionar o usuário ao grupo
function addGroupMember {
    param (
        [string]$group,
        [string]$user
    )
    $addToGroupCommand = "Add-LocalGroupMember -Group '$group' -Member '$user'"
    Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $addToGroupCommand" -Verb RunAs -Wait
}









$buttonReinstall.Add_Click({
    # Removendo serviços Xbox
    $command = @"
            Get-AppxPackage -AllUsers *Xbox* | Remove-AppxPackage
            Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
            Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage
            Get-AppxPackage *XboxIdentityProvider* | Remove-AppxPackage
"@

Invoke-Expression $command

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Reinicia o script com privilégios elevados
    Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $command" -Verb RunAs -Wait
    return
}
})






# Mostra o formulário
$form.ShowDialog()






