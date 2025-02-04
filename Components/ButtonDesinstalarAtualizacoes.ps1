Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonDesinstalarAtualizacoes {
    param (
        [string]$Text = "Desinstalar Atualizacoes Recentes", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonDesinstalarAtualizacoes = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonDesinstalarAtualizacoes -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonDesinstalarAtualizacoes)

    $buttonDesinstalarAtualizacoes.Add_Click({
        Write-Host "Verificando atualizacoes instaladas nos ultimos 7 dias..." -ForegroundColor Cyan
    
        # Obtem as atualizacoes instaladas nos ultimos 7 dias
        $atualizacoes = Get-HotFix | Where-Object { $_.InstalledOn -gt (Get-Date).AddDays(-7) }
    
        if ($atualizacoes.Count -eq 0) {
            Write-Host "Nenhuma atualizacao encontrada nos ultimos 7 dias." -ForegroundColor Yellow
            [System.Windows.Forms.MessageBox]::Show("Nenhuma atualizacao encontrada nos ultimos 7 dias.", "Informacao", "OK", "Information")
            return
        }
    
        Write-Host "Atualizacoes encontradas nos ultimos 7 dias:" -ForegroundColor Cyan
        $atualizacoes | ForEach-Object {
            Write-Host "ID: $($_.HotFixID) | Data: $($_.InstalledOn) | Descricao: $($_.Description)"
        }
    
        Write-Host "Iniciando a desinstalacao das atualizacoes..." -ForegroundColor Cyan
    
        # Desinstala cada atualizacao
        foreach ($atualizacao in $atualizacoes) {
            $idAtualizacao = $atualizacao.HotFixID
            Write-Host "Desinstalando a atualizacao $idAtualizacao..." -ForegroundColor Cyan
    
            try {
                # Usa o wusa para desinstalar a atualizacao
                wusa /uninstall /kb:$idAtualizacao /quiet /norestart
                Write-Host "Atualizacao $idAtualizacao desinstalada com sucesso!" -ForegroundColor Green
            } catch {
                Write-Host "Erro ao desinstalar a atualizacao $idAtualizacao." -ForegroundColor Red
            }
        }

        AdicionarItemChecklist "Desinstaladas as atualizacoes recentes do Windows." 
    
        Write-Host "Todas as atualizacoes dos ultimos 7 dias foram desinstaladas!" -ForegroundColor Green
        [System.Windows.Forms.MessageBox]::Show("Todas as atualizacoes dos ultimos 7 dias foram desinstaladas!", "Concluido", "OK", "Information")
    })

    
    return $buttonDesinstalarAtualizacoes
}