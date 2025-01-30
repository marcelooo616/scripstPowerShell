Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"

function Set-ButtonStyle {
    param (
        [System.Windows.Forms.Button]$Button,
        [string]$Text,
        [int]$Width = 150,
        [int]$Height = 50,
        [int]$X = 10,
        [int]$Y = 10
    )

    # Aplicar propriedades básicas
    $Button.Text = $Text
    $Button.Size = New-Object System.Drawing.Size($Width, $Height)
    $Button.Location = New-Object System.Drawing.Point($X, $Y)
    $Button.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $Button.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $Button.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204) # Azul PowerShell
    $Button.ForeColor = [System.Drawing.Color]::White
    $Button.FlatAppearance.BorderSize = 0
    $Button.Cursor = [System.Windows.Forms.Cursors]::Hand # Ícone de mão ao passar o mouse

    # Efeito de hover (quando o mouse passa por cima)
   

    # Bordas arredondadas (simuladas)
    $Button.Region = [System.Drawing.Region]::FromHrgn((CreateRoundRectRgn 0 0 $Width $Height 15 15))
}

# Função para criar bordas arredondadas (requer P/Invoke)
function CreateRoundRectRgn {
    param (
        [int]$left,
        [int]$top,
        [int]$right,
        [int]$bottom,
        [int]$widthEllipse,
        [int]$heightEllipse
    )
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Gdi32 {
        [DllImport("gdi32.dll")]
        public static extern IntPtr CreateRoundRectRgn(int left, int top, int right, int bottom, int widthEllipse, int heightEllipse);
    }
"@
    return [Gdi32]::CreateRoundRectRgn($left, $top, $right, $bottom, $widthEllipse, $heightEllipse)
}