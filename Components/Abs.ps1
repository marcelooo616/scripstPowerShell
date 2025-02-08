Add-Type -AssemblyName System.Windows.Forms


# Cria um novo formulário
$form = New-Object System.Windows.Forms.Form
$form.Text = "Checklist ABS"
$form.Size = New-Object System.Drawing.Size(800, 600) # Aumentei o tamanho para caber mais checkboxes
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(12, 12, 12)
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.BackColor = [System.Drawing.Color]::FromArgb(4, 20, 36)



# Variável para armazenar o checklist
[string]$checklists = "O que foi feito:`n"


# Itens do checklist
$itemsChecklist = @(
    "Verificado a versao do Windows.",
    "Reinstalados os servicos do Xbox.",
    "Reinstalados os servicos de jogos.",
    "Verificar e Reparar",
    "Atualizado o DNS do sistema.",
    "Criado um novo usuario de teste.",
    "Verificado e ajustado o fuso horario do sistema.",
    "Resetada a cache da Microsoft Store usando WsReset.",
    "Reparados os servicos de jogos do Windows.",
    "Reinstalados os servicos principais do Windows.",
    "Reiniciado o servico do Windows Update.",
    "Resetadas as configuracoes de rede.",
    "Realizado um reparo do Windows via Inplace Upgrade.",
    "Desinstaladas as atualizacoes recentes do Windows."
)

# Lista para armazenar os checkboxes
$checkboxes = @()

# Posicionamento inicial
$XPos1 = 10  # Posição X da primeira coluna
$XPos2 = 400 # Posição X da segunda coluna
$YPos = 10   # Posição Y inicial
$Spacing = 60 # Espaçamento vertical entre os checkboxes

# Cria os checkboxes dinamicamente
for ($i = 0; $i -lt $itemsChecklist.Length; $i++) {
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Text = $itemsChecklist[$i]
    $checkbox.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular)
    $checkbox.Size = New-Object System.Drawing.Size(375, 50)
    $checkbox.AutoSize = $false # Largura ajustada para caber duas colunas
    $checkbox.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Azul PowerShell
    $checkbox.ForeColor = [System.Drawing.Color]::White
    $checkbox.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $checkbox.FlatAppearance.BorderSize = 0
    $checkbox.CheckAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $checkbox.Padding = New-Object System.Windows.Forms.Padding(10, 0, 0, 0)
    $checkbox.Cursor = [System.Windows.Forms.Cursors]::Hand
    
 
    

    # Alterna entre as colunas
    if ($i % 2 -eq 0) {
        $checkbox.Location = New-Object System.Drawing.Point($XPos1, $YPos) # Coluna 1
    } else {
        $checkbox.Location = New-Object System.Drawing.Point($XPos2, $YPos) # Coluna 2
        $YPos += $Spacing # Avança para a próxima linha após adicionar um par
    }

 

    $checkbox.Add_Click({
        param($sender, $eventArgs)
        
        # Alterna a cor de fundo dependendo do estado do checkbox
        if ($sender.Checked) {
            $sender.BackColor = [System.Drawing.Color]::FromArgb(15, 76, 137)
        } else {
            $sender.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Cor original
        }
    })
    

    $form.Controls.Add($checkbox)
    $checkboxes += $checkbox
}




# Botão para confirmar
$button = New-Object System.Windows.Forms.Button
$button.Text = "Copiar ABS"
$button.Location = New-Object System.Drawing.Point(650, 500) # Posiciona o botão abaixo dos checkboxes
$button.Size = New-Object System.Drawing.Size(100, 40)
$button.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
$button.ForeColor = [System.Drawing.Color]::White
$button.Cursor = [System.Windows.Forms.Cursors]::Hand


$button.Add_Click({
    $script:checklists = "O que foi feito:`n"

    foreach ($checkbox in $checkboxes) {
        if ($checkbox.Checked) {
            $script:checklists += "- $($checkbox.Text)`n"
        }
    }

    # Copia para a área de transferência
    [System.Windows.Forms.Clipboard]::SetText($script:checklists)
    [System.Windows.Forms.MessageBox]::Show($script:checklists, "ABS Copiado")

    # Fecha o formulário
    $form.Close()
})

$form.Controls.Add($button)

# Exibe o formulário
function Show-Form {
    $form.ShowDialog()
}