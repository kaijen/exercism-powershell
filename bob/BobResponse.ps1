Function Get-BobResponse() {
    <#
    .SYNOPSIS
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.
    
    .DESCRIPTION
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.

    Bob answers 'Sure.' if you ask him a question.

    He answers 'Whoa, chill out!' if you yell at him.

    He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

    He says 'Fine. Be that way!' if you address him without actually saying
    anything.

    He answers 'Whatever.' to anything else.
    
    .PARAMETER HeyBob
    The sentence you say to Bob.
    
    .EXAMPLE
    Get-BobResponse -HeyBob "Hi Bob"
    #>
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )

    $HeyBob = $HeyBob.Trim()

    [bool] $isSilent = Test-IsEmpty -HeyBob $HeyBob
    [bool] $isQuestion = Test-IsQuestion -HeyBob $HeyBob
    [bool] $isYelling = Test-IsYelling -HeyBob $HeyBob

    if ( $isSilent ) {
         return "Fine. Be that way!"
    }
    if ( $isQuestion -and $isYelling ) {
         return "Calm down, I know what I'm doing!"
    }
    if ( $isYelling ) {
         return "Whoa, chill out!"
    }
    if ( $isQuestion ) {
         return "Sure."
    }
    return "Whatever."
}

Function Test-IsQuestion() {
    Param (
        [String] $HeyBob
    )
    return ( $HeyBob[-1] -ceq "?" )
}

function Test-IsEmpty() {
    param (
        [string] $HeyBob
    )

    return( $HeyBob.Length -eq 0 )    
}


function Test-IsYelling {
    param (
        [string] $HeyBob
    )

    [bool] $IsShout = ( $HeyBob -ceq $HeyBob.ToUpper() )
    [bool] $ContainsCharacter = ( $HeyBob -cmatch '[A-Z]' )

    return ( $IsShout -and $ContainsCharacter ) 
}
