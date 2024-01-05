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

    $dna = [string[]]@("G", "C", "T", "A")
    $rna = [string[]]@("C", "G", "A", "U")
    $combine = [Func[string, string, [string[]]]] { @($args[0], $args[1]) }
    $transcription = @{}

    # Wanted to see if there is a Python like ZIP in Powershell ;-)
    [Linq.Enumerable]::Zip($dna,$rna,$combine) | ForEach-Object { $transcription.Add($_[0],$_[1]) }

    if ( ( $Strand.ToUpper() -Replace "[GCTA]","" ).Length -ne 0 ) {
        Throw "Not a vald strand"
    }

    return ( $Strand.ToUpper() -Split "" | ForEach-Object { $_ -Replace $_, $transcription[$_] } ) -join ""
}
