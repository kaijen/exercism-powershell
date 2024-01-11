Function Invoke-ArmstrongNumbers() {
    <#
    .SYNOPSIS
    Determine if a number is an Armstrong number.

    .DESCRIPTION
    An Armstrong number is a number that is the sum of its own digits each raised to the power of the number of digits.

    .PARAMETER Number
    The number to check.

    .EXAMPLE
    Invoke-ArmstrongNumbers -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $base = 10
    $Digits = @()
    $remainder = $Number
    while ( $remainder -gt 0 ) {
        $Digits += $remainder % $base
        $remainder = [int][Math]::Floor( $remainder / $base )
    }

    $Len = $Digits.Count
    $sum = ($Digits | ForEach-Object { [Math]::Pow($_, $Len) } | Measure-Object -Sum).Sum

    return $sum -eq $Number
}
