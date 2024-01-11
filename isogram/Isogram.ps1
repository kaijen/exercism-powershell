Function Invoke-Isogram() {
    <#
    .SYNOPSIS
    Determine if a word or phrase is an isogram.

    .DESCRIPTION
    An isogram (also known as a "nonpattern word") is a word or phrase without a repeating letter,
    however spaces and hyphens are allowed to appear multiple times.

    .PARAMETER Phrase
    The phrase to check if it is an isogram.

    .EXAMPLE
    Invoke-Isogram -Phrase "isogram"

    Returns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )

    $counts = @{}
    $Phrase.ToLower() -split "" | Where-Object { $_ -match '[a-z]' } | ForEach-Object { $counts[$_]++ }

    return ( $counts.Values | Measure-Object -Maximum ).Maximum -le 1
}exc
