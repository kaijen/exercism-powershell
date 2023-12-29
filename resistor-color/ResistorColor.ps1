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

    $Color = $Color.ToLower()
    
    [array] $colors = Get-Colors

    [bool] $color_defined = $colors.Contains($Color)

    if ( -not $color_defined ) {
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
