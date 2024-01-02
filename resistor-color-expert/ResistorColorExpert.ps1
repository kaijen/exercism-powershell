[cultureinfo]::currentculture = 'en-US'

Function Get-ColorCode() {
    <#
    .SYNOPSIS
    Translate a color to its corresponding color code.

    .DESCRIPTION
    Given a color, return its corresponding color code.

    .PARAMETER Color
    The color to translate to its corresponding color code.

    .EXAMPLE
    Get-ColorCode -Color "black"
    #>
    [CmdletBinding()]
    Param(
        [string]$Color
    )

    $colors_hash = @{}

    Get-Colors | ForEach-Object { $i = 0 } { $colors_hash.Add($_, ($i++)) }

    if ( $null -eq $colors_hash[$Color] ) {
        throw $Color + " is not defined!"
    }

    return $colors_hash[$Color]
}

Function Get-Colors() {
    <#
    .SYNOPSIS
    Return the list of all colors.

    .DESCRIPTION
    Return the list of all colors.

    .EXAMPLE
    Get-Colors
    #>

    return @("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
}

Function Get-ResistorResistance() {
    <#
    .SYNOPSIS
    Implement a function to get the resitance of a resistor with three color-coded bands.

    .DESCRIPTION
    Given an array of colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array repesent the 3 colors from left to right.

    .EXAMPLE
    Get-ResistorResistance -Colors @("red", "white", "blue")
    Return: "29 megaohms"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )

    $exponent = 0
    if ($Colors.Length -gt 2 ) {
        $exponent = Get-ColorCode($Colors[-1])
        $Colors = $Colors[0..($Colors.Length-2)]
    }

    $resistance_base = 0
    foreach ($c in $Colors) {
        $resistance_base = (Get-ColorCode -Color $c) + $resistance_base * 10
    }

    $prefixes = @("", "kilo", "mega", "giga")
    $display_resistance = $resistance_base * [Math]::Pow(10, $exponent)

    $prefix_index = 0
    while ( $display_resistance -ge 1000 ) {
        $prefix_index++
        $display_resistance /= 1000
    }

    $prefix = $prefixes[$prefix_index]

    return "{0} {1}ohms" -f $display_resistance, $prefix
}

Function Get-ResistorTolerance() {
    <#
    .SYNOPSIS
    Translate a color to its corresponding color tolerance.

    .DESCRIPTION
    Given a color, return its corresponding color tolerance.

    .PARAMETER Color
    The color to translate to its corresponding color tolerance.

    .EXAMPLE
    Get-ResistorTolerance -Color "violet"
    #>
    [CmdletBinding()]
    Param(
        [string]$Color
    )

    $tolerances = @{ Grey = " ±0.05%"; Violet = " ±0.1%"; Blue = " ±0.25%"; Green = " ±0.5%"; Brown = " ±1%"; Red = " ±2%"; Gold = " ±5%"; Silver = " ±10 %" }

    if ( $null -eq $tolerances[$Color] ) {
        throw $Color + " is not defined!"
    }

    return $tolerances[$Color]
}

Function Get-ResistorLabel() {
    <#
    .SYNOPSIS
    Implement a function to get the label of a resistor from its color-coded bands.

    .DESCRIPTION
    Given an array of 1, 4 or 5 colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array represent the colors from left to right.

    .EXAMPLE
    Get-ResistorLabel -Colors @("red", "black", "green", "red")
    Return: "2 megaohms ±2%"

    Get-ResistorLabel -Colors @("blue", "blue", "blue", "blue", "blue")
    Return: "666 megaohms ±0.25%"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )

    $resistance = Get-ResistorResistance -Colors $Colors[0..($Colors.Length-2)]
    $tolerance = if ( $Colors.Length -gt 2 ) { Get-ResistorTolerance -Color $Colors[-1] } Else { "" }

    return "{0}{1}" -f $resistance, $tolerance
}