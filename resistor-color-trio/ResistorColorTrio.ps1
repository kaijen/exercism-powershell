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

    Get-Colors | ForEach-Object {$i=0} { $colors_hash.Add($_,($i++))}

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

Function Get-ResistorLabel() {
    <#
    .SYNOPSIS
    Implement a function to get the label of a resistor with three color-coded bands.

    .DESCRIPTION
    Given an array of colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array repesent the 3 colors from left to right.

    .EXAMPLE
    Get-ResistorLabel -Colors @("red", "white", "blue")
    Return: "29 megaohms"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )

    $units = [ordered]@{
        1e9 = "gigaohms"
        1e6 = "megaohms"
        1e3 = "kiloohms"
    }

    $resistance = ( ( 10 * (Get-ColorCode($Colors[0])) + (Get-ColorCode($Colors[1])) ) ) * [Math]::Pow(10, (Get-ColorCode($Colors[2])))

    foreach ($key in $units.Keys) {
        if ($resistance -gt $key) {
            return "$($resistance / $key) $($units[$key])"
        }
    }
    "$resistance ohms"
}