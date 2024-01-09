function Invoke-c14n {
    [CmdletBinding()]
    param (
        [String]$Subject
    )

    return ( $Subject.ToLower() -split "" | Sort-Object ) -join ""
}

Function Invoke-Anagram() {
    <#
    .SYNOPSIS
    Determine if a word is an anagram of other words in a list.

    .DESCRIPTION
    An anagram is a word formed by rearranging the letters of another word, e.g., spar, formed from rasp.
    Given a word and a list of possible anagrams, find the anagrams in the list.

    .PARAMETER Subject
    The word to check

    .PARAMETER Candidates
    The list of possible anagrams

    .EXAMPLE
    Invoke-Anagram -Subject "listen" -Candidates @("enlists" "google" "inlets" "banana")
    #>
    [CmdletBinding()]
    Param(
        [string]$Subject,
        [string[]]$Candidates
    )

    $Candidates | Where-Object { ( $_ -ne $Subject ) -and ( ( Invoke-c14n -Subject $_ ) -ceq ( Invoke-c14n -Subject $Subject ) ) }

}
