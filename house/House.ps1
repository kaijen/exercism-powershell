$poem_blocks = @(
    "house that Jack built",
    "malt that lay in",
    "rat that ate",
    "cat that killed",
    "dog that worried",
    "cow with the crumpled horn that tossed",
    "maiden all forlorn that milked",
    "man all tattered and torn that kissed",
    "priest all shaven and shorn that married",
    "rooster that crowed in the morn that woke",
    "farmer sowing his corn that kept",
    "horse and the hound and the horn that belonged to"
)

Function Get-RhymeLine() {
    Param(
        [int]$Verse,
        [string]$Line = ""
    )

    $insert =  $Line + " the " + ($poem_blocks[$Verse - 1])

    if ($Verse -eq 1) {
        return "This is${insert}."
    }
    else {
        return (Get-RhymeLine -Verse ($Verse-1) -Line $insert)
    }
}

Function Get-Rhyme() {
    <#
    .SYNOPSIS
    Recite the nursery rhyme 'This is the House that Jack Built'.

    .DESCRIPTION
    Given the start verse and the end verse, return a string reciting the rhyme from that range.

    .PARAMETER Start
    The start verse.

    .PARAMETER End
    The end verse.

    .EXAMPLE
    Get-Rhyme -Start 1 -End 2
    Return:
    @"
    This is the house that Jack built.
    This is the malt that lay in the house that Jack built.
    "@
     #>
    [CmdletBinding()]
    Param(
        [int]$Start,
        [int]$End
    )

    Write-Host "start: $Start end: $End"

    $rhyme = ""
    for ($i = $Start; $i -le $End; $i++) {
        $rhyme += ( Get-RhymeLine -Verse $i ) + "`n"
    }
    return $rhyme.Trim()
}