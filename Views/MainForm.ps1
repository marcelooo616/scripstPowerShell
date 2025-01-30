function Show-MainForm {
    # Importar componentes
    . "$PSScriptRoot/../Components/ButtonStyles.ps1"

    # Configurações da janela principal
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Gestor de Tarefas"
    $form.Size = New-Object System.Drawing.Size(800, 900)
    $form.BackColor = [System.Drawing.Color]::FromArgb(12, 12, 12) # Fundo escuro estilo PowerShell
    $form.ForeColor = [System.Drawing.Color]::White
    $form.Font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Regular)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
    $form.MaximizeBox = $false

    # Título da aplicação
    $labelTitle = New-Object System.Windows.Forms.Label
    $labelTitle.Text = "Gestor de Tarefas"
    $labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
    $labelTitle.ForeColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
    $labelTitle.AutoSize = $true
    $labelTitle.Location = New-Object System.Drawing.Point(20, 20)
    $form.Controls.Add($labelTitle)

    # Linha divisória
    $divider = New-Object System.Windows.Forms.Label
    $divider.Text = ""
    $divider.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $divider.Size = New-Object System.Drawing.Size(760, 2)
    $divider.Location = New-Object System.Drawing.Point(20, 60)
    $form.Controls.Add($divider)

    # Criar um PictureBox para exibir a imagem
    $pictureBox = New-Object System.Windows.Forms.PictureBox
    $pictureBox.Size = New-Object System.Drawing.Size(300, 300) # Tamanho da imagem
    $pictureBox.Location = New-Object System.Drawing.Point(450, 80) # Posição à direita dos botões
    $pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage # Ajustar tamanho da imagem


    # Definir o caminho da imagem
    $imagePath = "$PSScriptRoot\pngwing.png"  # Certifique-se de que a imagem está na mesma pasta do script
    if (Test-Path $imagePath) {
        $pictureBox.Image = [System.Drawing.Image]::FromFile($imagePath)
    } else {
        Write-Host "Imagem não encontrada em: $imagePath"
    }

    $form.Controls.Add($pictureBox)  # Adicionar a imagem ao formulário

     # Caixa de texto abaixo da imagem
     $textBox = New-Object System.Windows.Forms.TextBox
     $textBox.Multiline = $true
     $textBox.ReadOnly = $true
     $TextBox.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
     $textBox.Text = "Atencao: os procedimentos abaixo sao para problemas de um modo geral. Se o cliente estiver recebendo uma mensagem ou codigo de erro especifico, pesquise ele no support.xbox.com antes de realizar esses procedimentos."
     $textBox.Size = New-Object System.Drawing.Size(300, 185)
     $textBox.Location = New-Object System.Drawing.Point(450, 390)
     $textBox.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
     $textBox.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
     $textBox.ForeColor = [System.Drawing.Color]::White
     $textBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
     $form.Controls.Add($textBox)

    # Adicionar botões alinhados à esquerda
    $YPos = 80
    $Spacing = 60 

    New-ButtonVersionWin -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonWaReset -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonReinstalXbox -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonRepairServiceGames -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonReinstalServiceGames -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonReinstalServiceWin -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonCheckAndRepair -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonRestartUpdateServices -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonUpdateDNS -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonResetNetworkSettings -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonCreateUserAdm -ParentForm $form -Y $YPos | Out-Null
    $YPos += $Spacing
    New-ButtonInplace -ParentForm $form -Y $YPos | Out-Null

    # Botão de sair
    $buttonExit = New-Object System.Windows.Forms.Button
    $buttonExit.Text = "Sair"
    $buttonExit.Size = New-Object System.Drawing.Size(100, 40)
    $buttonExit.Location = New-Object System.Drawing.Point(650, 800)
    $buttonExit.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
    $buttonExit.ForeColor = [System.Drawing.Color]::White
    $buttonExit.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $buttonExit.FlatAppearance.BorderSize = 0
    $buttonExit.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $buttonExit.Add_Click({ $form.Close() })
    $form.Controls.Add($buttonExit)

    # Exibir a janela
    $form.ShowDialog()
}
