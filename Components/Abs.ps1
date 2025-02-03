# Ativar o suporte para Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Criar uma lista global para armazenar os itens selecionados
$global:checklist = New-Object System.Collections.ArrayList
