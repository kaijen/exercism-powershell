Enum Triangle {
    isosceles = 1
    equilateral
    scalene
}

Function Get-Triangle() {
    <#
    .SYNOPSIS
    Determine if a triangle is equilateral, isosceles, or scalene.

    .DESCRIPTION
    Given 3 sides of a triangle, return the type of that triangle if it is a valid triangle.

    .PARAMETER Sides
    The lengths of a triangle's sides.

    .EXAMPLE
    Get-Triangle -Sides @(1,2,3)
    Return: [Triangle]::SCALENE
    #>

    [CmdletBinding()]
    Param (
 #       [ValidateScript(
 #           {if ($_ -gt 0 ) { return $true }},
 #           ErrorMessage = "All side lengths must be positive."
 #       )]
        [double[]]$Sides
    )

    if ( ($sides | Measure-Object -Minimum).Minimum -le 0 ) {
        Throw "All side lengths must be positive."
    }

    for ($i = 0; $i -lt 3; $i++) {
        if ($sides[$i] -gt ($sides[($i + 1) % 3] + $sides[($i + 2) % 3])) {
            Throw "Side lengths violate triangle inequality."
        }
    }

    return [Triangle](($lengths.Values | Measure-Object Count).Count)
}