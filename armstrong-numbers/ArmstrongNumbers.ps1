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

    # Experiment with Github Copilot after some discussion how to convert a number to an array of digits.
    $digits = ( $Number.ToString().ToCharArray() | ForEach-Object { [int]([char]$_) - [int]([char]'0') } )
    $n = $digits.Length
    $sum = 0

    foreach ($digit in $digits) {
        $sum += [Math]::Pow([int]$digit, $n)
    }

    return $sum -eq $Number
}
