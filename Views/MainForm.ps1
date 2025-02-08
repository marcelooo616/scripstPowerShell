function Show-MainForm {
    # Importar componentes
    . "$PSScriptRoot/../Components/ButtonStyles.ps1"
   

    # Configurações da janela principal
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Gestor de Tarefas"
    $form.Size = New-Object System.Drawing.Size(800, 1000)
    $form.BackColor = [System.Drawing.Color]::FromArgb(4, 20, 36) # Fundo escuro estilo PowerShell
    $form.ForeColor = [System.Drawing.Color]::White
    $form.Font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Regular)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
    $form.MaximizeBox = $false

    # Título da aplicação
    $labelTitle = New-Object System.Windows.Forms.Label
    $labelTitle.Text = "Gestor de Tarefas"
    $labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
    $labelTitle.ForeColor = [System.Drawing.Color]::FromArgb(135, 188, 241)
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
    $pictureBox.Location = New-Object System.Drawing.Point(80, 600) # Posição à direita dos botões
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
    $textBox.Text = "Atencao: os procedimentos abaixo sao para problemas de um modo geral. Se voce estiver recebendo uma mensagem ou codigo de erro especifico, pesquise ele antes de realizar esses procedimentos."
    $textBox.Size = New-Object System.Drawing.Size(300, 185)
    $textBox.Location = New-Object System.Drawing.Point(450, 650)
    $textBox.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    $textBox.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $textBox.ForeColor = [System.Drawing.Color]::White
    $textBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $form.Controls.Add($textBox)

    # Adicionar botões em pares
    $YPos = 80
    $XPos1 = 20  # Posição X do primeiro botão do par
    $XPos2 = 300 # Posição X do segundo botão do par
    $Spacing = 60 # Espaçamento vertical entre os pares

    # Lista de funções de botões
    $buttonFunctions = @(
        "New-ButtonVersionWin",
        "New-ButtonWaReset",
        "New-ButtonReinstalXbox",
        "New-ButtonRepairServiceGames",
        "New-ButtonReinstalServiceGames",
        "New-ButtonReinstalServiceWin",
        "New-ButtonCheckAndRepair",
        "New-ButtonRestartUpdateServices",
        "New-ButtonUpdateDNS",
        "New-ButtonResetNetworkSettings",
        "New-ButtonCreateUserAdm",
        "New-ButtonInplace",
        "New-ButtonVerificarFusoHorario",
        "New-ButtonDesinstalarAtualizacoes"
    )

    # Adicionar botões em pares
    for ($i = 0; $i -lt $buttonFunctions.Length; $i += 2) {
        # Primeiro botão do par
        & $buttonFunctions[$i] -ParentForm $form -Y $YPos -X $XPos1 | Out-Null

        # Segundo botão do par (se existir)
        if ($i + 1 -lt $buttonFunctions.Length) {
            & $buttonFunctions[$i + 1] -ParentForm $form -Y $YPos -X $XPos2 | Out-Null
        }

        # Atualizar a posição Y para o próximo par
        $YPos += $Spacing
    }

    # Criar botão de copiar
    $copyButton = New-Object System.Windows.Forms.Button
    $copyButton.Text = "ABS"
    $copyButton.Size = New-Object System.Drawing.Size(100, 40)
    $copyButton.Location = New-Object System.Drawing.Point(650, 850)
    $copyButton.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
    $copyButton.ForeColor = [System.Drawing.Color]::White
    $copyButton.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $copyButton.Add_Click({
        . "$PSScriptRoot/../Components/Abs.ps1"
        Show-Form
    })


 $form.Controls.Add($copyButton)

    # Botão de sair
    $buttonExit = New-Object System.Windows.Forms.Button
    $buttonExit.Text = "Sair"
    $buttonExit.Size = New-Object System.Drawing.Size(100, 40)
    $buttonExit.Location = New-Object System.Drawing.Point(650, 900)
    $buttonExit.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
    $buttonExit.ForeColor = [System.Drawing.Color]::White
    $buttonExit.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $buttonExit.Add_Click({ 
        $form.Close()
     })
    $form.Controls.Add($buttonExit)

    # Exibir a janela
    $form.ShowDialog()
}