Add-Type -AssemblyName "System.Windows.Forms"

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptPath/Components/ButtonStyles.ps1"
. "$scriptPath/Components/ButtonWsReset.ps1"
. "$scriptPath/Components/ButtonVersionWin.ps1"
. "$scriptPath/Components/ButtonReinstalXbox.ps1"
. "$scriptPath/Components/ButtonRepairServiceGames.ps1"
. "$scriptPath/Components/ButtonReinstalServiceGames.ps1"
. "$scriptPath/Components/ButtonReinstalServiceWin.ps1"
. "$scriptPath/Components/ButtonCheckAndRepair.ps1"
. "$scriptPath/Components/ButtonRestartUpdateServices.ps1"
. "$scriptPath/Components/ButtonUpdateDNS.ps1"
. "$scriptPath/Components/ButtonResetNetworkSettings.ps1"
. "$scriptPath/Components/ButtonCreateUserAdm.ps1"
. "$scriptPath/Components/ButtonInplace.ps1"
. "$scriptPath/Components/ButtonVerificarFusoHorario.ps1"
. "$scriptPath/Components/ButtonDesinstalarAtualizacoes.ps1"
. "$scriptPath/Views/MainForm.ps1"

# Iniciar a aplicação
Show-MainForm
