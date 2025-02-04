# Ativar o suporte para Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Criar uma lista global para armazenar os itens selecionados

$global:checklists = "O que foi feito:`n"

function AdicionarItemChecklist {
    param (
        [string]$item
    )
    $global:checklists += "- $item`n"
}