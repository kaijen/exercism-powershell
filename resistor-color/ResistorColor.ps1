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

    [array] $colors = Get-Colors

    if ( $null -eq $colors.IndexOf($Color) ) {
        throw $Color + " is not defined!"
    }

    return $colors.IndexOf($Color)
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
    
    [array] $colors = "black",  "brown",  "red",  "orange",  "yellow",  "green",  "blue",  "violet",  "grey",  "white"
        
    return $colors
}
