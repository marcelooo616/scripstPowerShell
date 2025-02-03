Add-Type -AssemblyName "System.Windows.Forms"
function New-ButtonRestartUpdateServices {
    param (
        [string]$Text = "Reiniciar o Windows Update", 
        [int]$Width = 250,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10, 
        [int]$Spacing = 10,
        [System.Windows.Forms.Form]$ParentForm
    )

    $buttonRestartUpdateServices = New-Object System.Windows.Forms.Button

    Set-ButtonStyle -Button $buttonRestartUpdateServices -Text $Text -Width $Width -Height $Height -X $X -Y $Y
    
    $ParentForm.Controls.Add($buttonRestartUpdateServices)

    $buttonRestartUpdateServices.Add_Click({
        # Verificar se o script já está sendo executado como administrador
        if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            # Se não for administrador, solicitar permissão para elevar
            $elevate = [System.Windows.Forms.MessageBox]::Show(
                "Este comando requer permissões de administrador. Deseja executar como administrador?",
                "Permissão Necessária",
                [System.Windows.Forms.MessageBoxButtons]::YesNo,
                [System.Windows.Forms.MessageBoxIcon]::Question
            )
    
            if ($elevate -eq [System.Windows.Forms.DialogResult]::Yes) {
                # Reiniciar o script como administrador
                $scriptPath = $PSCommandPath
                Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
                return
            } else {
                # Se o usuário escolher "Não", encerrar a execução
                [System.Windows.Forms.MessageBox]::Show("Operação cancelada pelo usuário.", "Cancelado", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
                return
            }
        }
    
        # Se já estiver executando como administrador, continuar com o restante do código
        # Serviços que serão reiniciados
        $services = @("wuauserv", "bits")
    
        try {
            Write-Host "Parando os serviços do Windows Update e BITS..." -ForegroundColor Yellow
    
            # Parar os serviços
            foreach ($service in $services) {
                Stop-Service -Name $service -Force -ErrorAction Stop
                Write-Host "Serviço $service parado com sucesso." -ForegroundColor Green
            }
    
            Write-Host "Serviços parados. Reiniciando..." -ForegroundColor Yellow
    
            # Iniciar os serviços
            foreach ($service in $services) {
                Start-Service -Name $service -ErrorAction Stop
                Write-Host "Serviço $service reiniciado com sucesso." -ForegroundColor Green
            }
    
            Write-Host "Serviços do Windows Update e BITS reiniciados com sucesso!" -ForegroundColor Cyan
    
            # Exibir mensagem de sucesso na interface gráfica
            [System.Windows.Forms.MessageBox]::Show("Serviços do Windows Update e BITS reiniciados com sucesso!", "Sucesso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            $global:checklist.Add("Reiniciado o servico do Windows Update.") | Out-Null
        }
        catch {
            Write-Error "Ocorreu um erro ao reiniciar os serviços: $_"
    
            # Exibir mensagem de erro na interface gráfica
            [System.Windows.Forms.MessageBox]::Show("Ocorreu um erro ao reiniciar os serviços: $_", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    })

    
    

    return $buttonRestartUpdateServices
}