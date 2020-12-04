#####################
####variables
#####################
$VerbosePreference = "SilentlyContinue"
$WarningPreference = "Continue"
$DebugPreference = "Continue"
$ErrorActionPreference = "Continue"
$InformationPreference = "Continue"
#####################
####debug info
#####################
$dataPath = ".\Day2.csv"
$data = Import-Csv -Path $dataPath -Delimiter " "
$startTime = Get-Date
$pt1SuccessData = @()
$pt2SuccessData = @()
foreach ($line in $data)
{
    $lowMatch = $false
    $highMatch = $false
    #####################
    ####code for part 1
    #####################
    ##repeat letter pw
    $letter,$other = $line.letter.Split(":")
    $rangeLow,$rangeHigh = $line.repeat.Split('-')
    $range = $rangeLow..$rangeHigh
    $matchObj = $line.pw | Select-String -Pattern $letter -AllMatches
    $matchCount = $matchObj.Matches.Length
    Write-Verbose -Message "Range [$($rangeLow..$rangeHigh)] Match Count [$($matchCount)] Letter [$($letter)] PW [$($line.pw)]"
    if ($range.Contains($matchCount))
    {
        Write-Verbose -Message "Range [$($rangeLow..$rangeHigh)] Match Count [$($matchCount)] Letter [$($letter)] PW [$($line.pw)]"
        $pt1SuccessData += $line.pw
    }
    #####################
    ####code for part 2
    #####################
    if ($matchObj.Matches | Where-Object {$_.Index + 1 -eq $rangeLow -and $_.Value -eq $letter})
    {
        $lowMatch = $true
        Write-Verbose -Message "RangeLow [$($rangeLow)] Letter [$($letter)]"
    }
    if ($matchObj.Matches | Where-Object {$_.Index + 1 -eq $rangeHigh -and $_.Value -eq $letter})
    {
        $highMatch = $true
        Write-Verbose -Message "RangeHigh [$($rangeHigh)] Letter [$($letter)]"
    }
    if ($lowMatch -eq $true -and $highMatch -eq $true)
    {
        ##Not Good
    }
    elseif ($lowMatch -eq $false -and $highMatch -eq $false)
    {
        ##Not Good
    }
    else
    {
        $pt2SuccessData += $line.pw
    }
}
Write-Warning -Message "Pt 1 Good Passwords [$($pt1SuccessData.Count)]"
Write-Warning -Message "Pt 2 Good Passwords [$($pt2SuccessData.Count)]"
#####################
####closing code
#####################
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."

#####################
####output
#####################
##WARNING: Pt 1 Good Passwords [628]
##WARNING: Pt 2 Good Passwords [705]
##WARNING: Script took 0.3898267 seconds to run.