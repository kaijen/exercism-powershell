Function Invoke-Panagram() {
    <#
    .SYNOPSIS
    Determine if a sentence is a pangram.

    .DESCRIPTION
    A pangram is a sentence using every letter of the alphabet at least once.

    .PARAMETER Sentence
    The sentence to check

    .EXAMPLE
    Invoke-Panagram -Sentence "The quick brown fox jumps over the lazy dog"

    Returns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Sentence
    )

    $alphabet = [ordered]@{}
    [char]'a'..[char]'z' | Foreach-Object  {
        $alphabet[$_] = 0
    }

    $Sentence.ToLower().ToCharArray() | ForEach-Object {
        $alphabet[$_]++
    }

    return ( $alphabet.Values | Measure-Object -Minimum).Minimum -gt 0

}