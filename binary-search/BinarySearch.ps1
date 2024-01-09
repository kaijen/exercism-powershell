Function Invoke-BinarySearch() {
    <#
    .SYNOPSIS
    Perform a binary search on a sorted array.

    .DESCRIPTION
    Take an array of integers and a search value and return the index of the value in the array.

    .PARAMETER Array
    The array to search.

    .PARAMETER Value
    The value to search for.

    .EXAMPLE
    Invoke-BinarySearch -Array @(1, 2, 3, 4, 5) -Value 3
    #>
    [CmdletBinding()]
    Param(
        [Int64[]]$Array,
        [Int64]$Value
    )

    $left = 0
    $right = $array.Length - 1

    while ($left -le $right) {
        $mid = [Math]::Floor(($left + $right) / 2)

        if ($array[$mid] -eq $Value) {
            return $mid
        }
        elseif ($array[$mid] -lt $Value) {
            $left = $mid + 1
        }
        else {
            $right = $mid - 1
        }
    }

    Throw "error: value not in array"
}
