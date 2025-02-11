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
        function Get-CultureGeoID($cultureName) {
            $cultureTable = @{
                "af-ZA" = 710  # África do Sul
                "sq-AL" = 8    # Albânia
                "ar-DZ" = 12   # Argélia
                "ar-BH" = 48   # Bahrein
                "ar-EG" = 818  # Egito
                "ar-IQ" = 368  # Iraque
                "ar-JO" = 400  # Jordânia
                "ar-KW" = 414  # Kuwait
                "ar-LB" = 422  # Líbano
                "ar-LY" = 434  # Líbia
                "ar-MA" = 504  # Marrocos
                "ar-OM" = 512  # Omã
                "ar-QA" = 634  # Catar
                "ar-SA" = 682  # Arábia Saudita
                "ar-SY" = 760  # Síria
                "ar-TN" = 788  # Tunísia
                "ar-AE" = 784  # Emirados Árabes Unidos
                "ar-YE" = 887  # Iêmen
                "az-Latn-AZ" = 31  # Azerbaijão
                "be-BY" = 112  # Bielorrússia
                "bg-BG" = 100  # Bulgária
                "bn-BD" = 50   # Bangladesh
                "bn-IN" = 356  # Índia
                "bs-BA" = 70   # Bósnia e Herzegovina
                "ca-ES" = 724  # Espanha (Catalão)
                "cs-CZ" = 203  # Tchéquia
                "cy-GB" = 826  # Reino Unido (Galês)
                "da-DK" = 208  # Dinamarca
                "de-AT" = 40   # Áustria
                "de-DE" = 276  # Alemanha
                "de-CH" = 756  # Suíça
                "el-GR" = 300  # Grécia
                "en-AU" = 36   # Austrália
                "en-CA" = 124  # Canadá
                "en-GB" = 826  # Reino Unido
                "en-IN" = 356  # Índia
                "en-NZ" = 554  # Nova Zelândia
                "en-US" = 840  # Estados Unidos
                "es-AR" = 32   # Argentina
                "es-BO" = 68   # Bolívia
                "es-CL" = 152  # Chile
                "es-CO" = 170  # Colômbia
                "es-CR" = 188  # Costa Rica
                "es-DO" = 214  # República Dominicana
                "es-EC" = 218  # Equador
                "es-ES" = 724  # Espanha
                "es-GT" = 320  # Guatemala
                "es-MX" = 484  # México
                "es-NI" = 558  # Nicarágua
                "es-PA" = 591  # Panamá
                "es-PE" = 604  # Peru
                "es-PR" = 630  # Porto Rico
                "es-PY" = 600  # Paraguai
                "es-SV" = 222  # El Salvador
                "es-UY" = 858  # Uruguai
                "es-VE" = 862  # Venezuela
                "et-EE" = 233  # Estônia
                "fa-IR" = 364  # Irã
                "fi-FI" = 246  # Finlândia
                "fr-BE" = 56   # Bélgica
                "fr-CA" = 124  # Canadá
                "fr-FR" = 250  # França
                "fr-CH" = 756  # Suíça
                "he-IL" = 376  # Israel
                "hi-IN" = 356  # Índia
                "hr-HR" = 191  # Croácia
                "hu-HU" = 348  # Hungria
                "id-ID" = 360  # Indonésia
                "is-IS" = 352  # Islândia
                "it-IT" = 380  # Itália
                "ja-JP" = 392  # Japão
                "kk-KZ" = 398  # Cazaquistão
                "ko-KR" = 410  # Coreia do Sul
                "lt-LT" = 440  # Lituânia
                "lv-LV" = 428  # Letônia
                "mk-MK" = 807  # Macedônia do Norte
                "ms-MY" = 458  # Malásia
                "mt-MT" = 470  # Malta
                "nb-NO" = 578  # Noruega (Bokmål)
                "nl-BE" = 56   # Bélgica (Neerlandês)
                "nl-NL" = 528  # Países Baixos
                "nn-NO" = 578  # Noruega (Nynorsk)
                "pl-PL" = 616  # Polônia
                "pt-BR" = 76   # Brasil
                "pt-PT" = 620  # Portugal
                "ro-RO" = 642  # Romênia
                "ru-RU" = 643  # Rússia
                "sk-SK" = 703  # Eslováquia
                "sl-SI" = 705  # Eslovênia
                "sr-Cyrl-RS" = 688  # Sérvia (Cirílico)
                "sr-Latn-RS" = 688  # Sérvia (Latim)
                "sv-SE" = 752  # Suécia
                "th-TH" = 764  # Tailândia
                "tr-TR" = 792  # Turquia
                "uk-UA" = 804  # Ucrânia
                "vi-VN" = 704  # Vietnã
                "zh-CN" = 156  # China (Simplificado)
                "zh-HK" = 344  # Hong Kong
                "zh-TW" = 158  # Taiwan
            }
            
            return $cultureTable[$cultureName]
        }

        function Get-GeoIDName($geoId) {
            
            $geoTable = @{
                4 = "Afeganistão"
                8 = "Albânia"
                12 = "Argélia"
                20 = "Andorra"
                24 = "Angola"
                28 = "Antígua e Barbuda"
                32 = "Argentina"
                36 = "Austrália"
                40 = "Áustria"
                44 = "Bahamas"
                48 = "Bahrein"
                50 = "Bangladesh"
                51 = "Armênia"
                52 = "Barbados"
                56 = "Bélgica"
                64 = "Butão"
                68 = "Bolívia"
                70 = "Bósnia e Herzegovina"
                72 = "Botsuana"
                76 = "Brasil"
                84 = "Belize"
                100 = "Bulgária"
                104 = "Mianmar"
                108 = "Burundi"
                112 = "Bielorrússia"
                116 = "Camboja"
                120 = "Camarões"
                124 = "Canadá"
                132 = "Cabo Verde"
                136 = "Ilhas Cayman"
                140 = "República Centro-Africana"
                144 = "Sri Lanka"
                148 = "Chade"
                152 = "Chile"
                156 = "China"
                170 = "Colômbia"
                174 = "Comores"
                178 = "Congo"
                180 = "República Democrática do Congo"
                188 = "Costa Rica"
                191 = "Croácia"
                192 = "Cuba"
                196 = "Chipre"
                203 = "Tchéquia"
                208 = "Dinamarca"
                214 = "República Dominicana"
                218 = "Equador"
                222 = "El Salvador"
                226 = "Guiné Equatorial"
                231 = "Etiópia"
                233 = "Estônia"
                242 = "Fiji"
                246 = "Finlândia"
                250 = "França"
                268 = "Geórgia"
                270 = "Gâmbia"
                276 = "Alemanha"
                288 = "Gana"
                300 = "Grécia"
                320 = "Guatemala"
                324 = "Guiné"
                328 = "Guiana"
                332 = "Haiti"
                340 = "Honduras"
                344 = "Hong Kong"
                348 = "Hungria"
                352 = "Islândia"
                356 = "Índia"
                360 = "Indonésia"
                364 = "Irã"
                368 = "Iraque"
                372 = "Irlanda"
                376 = "Israel"
                380 = "Itália"
                392 = "Japão"
                398 = "Cazaquistão"
                400 = "Jordânia"
                408 = "Coreia do Norte"
                410 = "Coreia do Sul"
                414 = "Kuwait"
                417 = "Quirguistão"
                418 = "Laos"
                422 = "Líbano"
                426 = "Lesoto"
                428 = "Letônia"
                440 = "Lituânia"
                442 = "Luxemburgo"
                450 = "Madagascar"
                454 = "Malawi"
                458 = "Malásia"
                462 = "Maldivas"
                466 = "Mali"
                470 = "Malta"
                478 = "Mauritânia"
                480 = "Maurício"
                484 = "México"
                498 = "Moldávia"
                504 = "Marrocos"
                512 = "Omã"
                516 = "Namíbia"
                524 = "Nepal"
                528 = "Países Baixos"
                530 = "Curaçao"
                533 = "Aruba"
                540 = "Nova Caledônia"
                548 = "Vanuatu"
                554 = "Nova Zelândia"
                558 = "Nicarágua"
                566 = "Nigéria"
                578 = "Noruega"
                586 = "Paquistão"
                591 = "Panamá"
                598 = "Papua-Nova Guiné"
                600 = "Paraguai"
                604 = "Peru"
                608 = "Filipinas"
                616 = "Polônia"
                620 = "Portugal"
                634 = "Catar"
                642 = "Romênia"
                643 = "Rússia"
                646 = "Ruanda"
                682 = "Arábia Saudita"
                686 = "Senegal"
                688 = "Sérvia"
                694 = "Serra Leoa"
                702 = "Singapura"
                703 = "Eslováquia"
                704 = "Vietnã"
                705 = "Eslovênia"
                710 = "África do Sul"
                716 = "Zimbábue"
                724 = "Espanha"
                729 = "Sudão"
                740 = "Suriname"
                752 = "Suécia"
                756 = "Suíça"
                760 = "Síria"
                762 = "Tajiquistão"
                764 = "Tailândia"
                784 = "Emirados Árabes Unidos"
                788 = "Tunísia"
                792 = "Turquia"
                795 = "Turcomenistão"
                800 = "Uganda"
                804 = "Ucrânia"
                818 = "Egito"
                826 = "Reino Unido"
                834 = "Tanzânia"
                840 = "Estados Unidos"
                854 = "Burkina Faso"
                858 = "Uruguai"
                860 = "Uzbequistão"
                862 = "Venezuela"
                887 = "Iêmen"
                894 = "Zâmbia"
            }
            
            return $geoTable[$geoId]
        }

        $culture = Get-Culture
        $cultureName = $culture.Name

        # Obtém o GeoID a partir do código de cultura
        $geoId = Get-CultureGeoID $cultureName

        # Se o GeoID não for encontrado na tabela, define como desconhecido
        if (-not $geoId) {
            $geoId = 0
            $nomePaisRegiao = "Desconhecido"
        } else {
            $nomePaisRegiao = Get-GeoIDName $geoId
        }

        # Obtém o fuso horário atual do sistema
        $timeZone = Get-TimeZone
        $agora = Get-Date
    
        # Obtém informações sobre a região e idioma
        $systemLocale = Get-WinSystemLocale
        $homeLocation = Get-WinHomeLocation

        # Cria um objeto com as informações
        $info = [PSCustomObject]@{
            FusoHorario       = $timeZone.Id
            NomeExibicao      = $timeZone.DisplayName
            HorarioAtual      = $agora.ToString("HH:mm:ss")
            DataAtual         = $agora.ToString("dd/MM/yyyy")
            DiferencaUTC      = $timeZone.BaseUtcOffset.ToString("hh\:mm")
            AjusteVerao       = if ($timeZone.SupportsDaylightSavingTime) { "Sim" } else { "Não" }
            HorarioVeraoAtivo = if ($timeZone.IsDaylightSavingTime($agora)) { "Sim" } else { "Não" }
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
        Pais/Regiao: $($info.geoId) - $($info.NomePaisRegiao)
"@
        
 })

    return $buttonVerificarFusoHorario
}

