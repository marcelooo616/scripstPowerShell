Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonInplace {
    param (
        [string]$Text = "Inplace", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonInplace = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonInplace -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonInplace)



    $buttonInplace.Add_Click({
        # Definir caminho padrão na Área de Trabalho
        $desktopPath = "$env:USERPROFILE\Desktop"
    
        # Criar uma nova janela
        $form = New-Object System.Windows.Forms.Form
        $form.Text = "Escolha a versao do Windows"
        $form.Size = New-Object System.Drawing.Size(400,200)
        $form.StartPosition = "CenterScreen"
        $form.BackColor = [System.Drawing.Color]::FromArgb(12, 12, 12)
        $form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    
        # Título da janela
        $labelTitle = New-Object System.Windows.Forms.Label
        $labelTitle.Text = "Selecione a versao do Windows para baixar:"
        $labelTitle.AutoSize = $true
        $labelTitle.Location = New-Object System.Drawing.Point(20, 20)
        $labelTitle.ForeColor = [System.Drawing.Color]::White
        $form.Controls.Add($labelTitle)
    
        # Criar botão para Windows 10
        $buttonWin10 = New-Object System.Windows.Forms.Button
        $buttonWin10.Text = "Windows 10"
        $buttonWin10.Size = New-Object System.Drawing.Size(150,40)
        $buttonWin10.Location = New-Object System.Drawing.Point(30,80)
        $buttonWin10.BackColor = [System.Drawing.Color]::RoyalBlue
        $buttonWin10.ForeColor = [System.Drawing.Color]::White
        $buttonWin10.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
        $buttonWin10.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
        

        $buttonWin10.Add_Click({
            try {
                # Definir o caminho completo do arquivo de destino
                $destinationFile = "$desktopPath\MediaCreationTool_22H2.exe"
                
                # Baixar o Media Creation Tool usando Invoke-WebRequest
                Invoke-WebRequest -Uri "http://go.microsoft.com/fwlink/?LinkId=691209" -OutFile $destinationFile
                
                # Executar o arquivo baixado
                Start-Process -FilePath $destinationFile
    
                # Exibir mensagem de sucesso
                [System.Windows.Forms.MessageBox]::Show("Download do Media Creation Tool concluído com sucesso! O programa será aberto.", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            } catch {
                # Exibir mensagem de erro
                [System.Windows.Forms.MessageBox]::Show("Erro ao baixar ou executar o Media Creation Tool: $($_.Exception.Message)", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            } finally {
                $form.Close()
            }
        })
        
        # Criar botão para Windows 11
        $buttonWin11 = New-Object System.Windows.Forms.Button
        $buttonWin11.Text = "Windows 11"
        $buttonWin11.Size = New-Object System.Drawing.Size(150,40)
        $buttonWin11.Location = New-Object System.Drawing.Point(200,80)
        $buttonWin11.BackColor = [System.Drawing.Color]::DarkOrange
        $buttonWin11.ForeColor = [System.Drawing.Color]::White
        $buttonWin11.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
        $buttonWin11.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
        $buttonWin11.Add_Click({
            try {
                # Definir o caminho completo do arquivo de destino
                $destinationFile = "$desktopPath\MediaCreationTool_22H2.exe"
                
                # Baixar o Media Creation Tool usando Invoke-WebRequest
                Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2156295" -OutFile $destinationFile
                
                # Executar o arquivo baixado
                Start-Process -FilePath $destinationFile
    
                # Exibir mensagem de sucesso
                [System.Windows.Forms.MessageBox]::Show("Download do Media Creation Tool concluído com sucesso! O programa será aberto.", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
                $global:checklist.Add("Realizado um reparo do Windows via Inplace Upgrade.") | Out-Null
            } catch {
                # Exibir mensagem de erro
                [System.Windows.Forms.MessageBox]::Show("Erro ao baixar ou executar o Media Creation Tool: $($_.Exception.Message)", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            } finally {
                $form.Close()
            }
        })
    
        # Adicionar os botões ao formulário
        $form.Controls.Add($buttonWin10)
        $form.Controls.Add($buttonWin11)
    
        # Mostrar a janela
        $form.ShowDialog()
    })

    
    

    return $buttonInplace
}

