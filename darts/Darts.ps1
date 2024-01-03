[cultureinfo]::currentculture = 'en-US'
Function Invoke-Darts() {
    <#
    .SYNOPSIS
    Calculate the earned points in a single toss of a Darts game.

    .DESCRIPTION
    Take a coordinate of a point and calculate the distance from the center of the dartboard.
    Then depending on the distance and which concentric circle the point lies in, return the
    number of points earned.

    .PARAMETER X
    The X coordinate of the dart.

    .PARAMETER Y
    The Y coordinate of the dart.

    .EXAMPLE
    Invoke-Darts -X 0 -Y 10
    #>
    [CmdletBinding()]
    Param(
        [Double]$X,
        [Double]$Y
    )

    $scores = [ordered]@{ 1.0 = 10; 5.0 = 5; 10.0 = 1}

    $radius = [Math]::Sqrt( $X*$X + $Y*$Y )

    foreach ( $r in $scores.Keys ) {
        if ( $radius -le $r ) {
            return $scores[$r]
        }
    }

    return 0
}
