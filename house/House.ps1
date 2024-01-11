$poem_blocks = @(
    "the house that Jack built",
    "the malt that lay in",
    "the rat that ate",
    "the cat that killed",
    "the dog that worried",
    "the cow with the crumpled horn that tossed",
    "the maiden all forlorn that milked",
    "the man all tattered and torn that kissed",
    "the priest all shaven and shorn that married",
    "the rooster that crowed in the morn that woke",
    "the farmer sowing his corn that kept",
    "the horse and the hound and the horn that belonged to"
)

Function Get-RhymeLine() {
    Param(
        [int]$Verse,
        [string]$Line = ""
    )

    if ($Verse -eq 1) {
        return "This is $Line$($poem_blocks[$Verse - 1])."
    }
    else {
        return (Get-RhymeLine -Verse ($Verse-1) -Line ($Line + ($poem_blocks[$Verse - 1]) + " "))
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