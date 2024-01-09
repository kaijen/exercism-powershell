Function Invoke-RnaTranscription() {
    <#
    .SYNOPSIS
    Transcribe a DNA strand into RNA.

    .DESCRIPTION
    Given a DNA strand, return its RNA complement (per RNA transcription).

    .PARAMETER Strand
    The DNA strand to transcribe.

    .EXAMPLE
    Invoke-RnaTranscription -Strand "A"
    #>
    [CmdletBinding()]
    Param(
        [string]$Strand
    )

    0..3 | ForEach-Object { $transcription = @{}; $keys = 'ATCG'; $values = 'UAGC' } { $transcription["$($keys[$_])"] = $values[$_]}


    if ( ( $Strand.ToUpper() -Replace "[GCTA]","" ).Length -ne 0 ) {
        Throw "Not a vald strand"
    }

    return ( $Strand.ToUpper() -Split "" | ForEach-Object { $_ -Replace $_, $transcription[$_] } ) -join ""
}
