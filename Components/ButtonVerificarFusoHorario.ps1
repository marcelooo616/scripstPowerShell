Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonVerificarFusoHorario {
    param (
        [string]$Text = "Verificar Fuso Horario", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonVerificarFusoHorario = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonVerificarFusoHorario -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonVerificarFusoHorario)

   
    $buttonVerificarFusoHorario.Add_Click({
        # Função para mapear GeoID para nome de país/região
        function Get-GeoIDName($geoId) {
            $geoTable = @{
                32 = "Argentina"
                36 = "Austrália"
                40 = "Áustria"
                56 = "Bélgica"
                76 = "Brasil"
                124 = "Canadá"
                156 = "China"
                250 = "França"
                276 = "Alemanha"
                380 = "Itália"
                392 = "Japão"
                724 = "Espanha"
                826 = "Reino Unido"
                840 = "Estados Unidos"
            }
            return $geoTable[$geoId]
        }
    
        # Obtém o fuso horário atual do sistema
        $timeZone = Get-TimeZone
        $agora = Get-Date
    
        # Obtém informações sobre a região e idioma
        $systemLocale = Get-WinSystemLocale
        $homeLocation = Get-WinHomeLocation
        $geoId = $homeLocation.GeoId
        $nomePaisRegiao = Get-GeoIDName $geoId
    
        # Cria um objeto com as informações
        $info = [PSCustomObject]@{
            FusoHorario       = $timeZone.Id
            NomeExibicao      = $timeZone.DisplayName
            HorarioAtual      = $agora.ToString("HH:mm:ss")
            DataAtual         = $agora.ToString("dd/MM/yyyy")
            DiferencaUTC      = $timeZone.BaseUtcOffset.ToString("hh\:mm")
            AjusteVerao       = if ($timeZone.SupportsDaylightSavingTime) { "Sim" } else { "Não" }
            HorarioVeraoAtivo = if ($timeZone.IsDaylightSavingTime($agora)) { "Sim" } else { "Não" }
            IdiomaSistema     = $systemLocale.Name
            GeoID             = $geoId
            NomePaisRegiao    = $nomePaisRegiao
        }
    
        # Exibe o relatório em uma caixa de mensagem
        Write-Host  Write-Host @"
        Relatorio de Fuso Horario e Regiao
    
        Fuso Horario: $($info.FusoHorario)
        Nome de Exibicao: $($info.NomeExibicao)
        Horario Atual: $($info.HorarioAtual)
        Data Atual: $($info.DataAtual)
        Diferenca para UTC: $($info.DiferencaUTC)
        Ajuste de Horario de Verao Suportado: $($info.AjusteVerao)
        Horario de Verao Ativo: $($info.HorarioVeraoAtivo)
        Idioma do Sistema: $($info.IdiomaSistema)
        Pais/Regiao: $($info.geoId) - $($info.NomePaisRegiao)
"@
    })

    $global:checklist.Add("Verificado e ajustado o fuso horario do sistema.") | Out-Null
    
    
    
    return $buttonVerificarFusoHorario
}