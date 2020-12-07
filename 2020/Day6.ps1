#####################
####debug info
#####################
$VerbosePreference = "SilentlyContinue"##SilentlyContinue,Continue
$WarningPreference = "Continue"
$DebugPreference = "Continue"
$ErrorActionPreference = "Continue"
$InformationPreference = "Continue"
#####################
####variables
#####################
$dataPath = ".\2020\Day6.txt"
$data = Get-Content -Path $dataPath
[System.Collections.ArrayList]$parsedData = @()
[int]$lineCounter = 0##lines in the txt file
[int]$peopleCounter = 0##lines of logical csv data
[int]$groupCounter = 1##lines of logical csv data
$startTime = Get-Date

foreach ($line in $data)
{
    $lineCounter++
    $peopleCounter++
    $customsDelarations = [PSCustomObject]@{
        line = $lineCounter
        personID = $peopleCounter
        groupID = $groupCounter
        rawdata = $line
    }
    if ($line -eq "")
    {
        $groupCounter++
        $peopleCounter--
        Continue
    }
    else
    {
        $parsedData.Add($customsDelarations) | Out-Null
    }
}
Write-Warning -Message "Lines of Data [$($lineCounter)] People [$($peopleCounter)] Groups [$($groupCounter)]"
##Possible Answers: a, b, c, x, y, and z
$minGroupID = $parsedData | Sort-Object -Property groupID | Select-Object -First 1 -ExpandProperty groupID
$maxGroupID = $parsedData | Sort-Object -Property groupID -Descending | Select-Object -First 1 -ExpandProperty groupID
[System.Collections.ArrayList]$anyAnswersPerGroup = @()
[System.Collections.ArrayList]$everyAnswersPerGroup = @()
for ($int=$minGroupID; $int -le $maxGroupID; $int++)
{
    $letterArray = "a".."z"
    $pt1AnswerArray = @()
    $pt2AnswerArray = @()
    $selectedData = $parsedData | Where-Object {$_.groupID -eq $int}
    $pt1GroupAnswers = [PSCustomObject]@{}
    $pt1GroupAnswers | Add-Member -MemberType NoteProperty -Name groupID -Value $int
    $pt2GroupAnswers = [PSCustomObject]@{}
    $pt2GroupAnswers | Add-Member -MemberType NoteProperty -Name groupID -Value $int
    $peopleInGroup = $selectedData.Count
    foreach ($letter in $letterArray)
    {
        if ($selectedData.rawdata | Select-String -Pattern $letter -SimpleMatch)
        {
            Set-Variable -Name "$($letter)" -Value $true
            $pt1AnswerArray += "$($letter)"
            $pt1GroupAnswers | Add-Member -MemberType NoteProperty -Name "$($letter)Status" -Value $true
        }
        if (($selectedData.rawdata | Select-String -Pattern $letter).Matches.Count -eq $peopleInGroup)
        {
            Set-Variable -Name "$($letter)" -Value $true
            $pt2AnswerArray += "$($letter)"
            $pt2GroupAnswers | Add-Member -MemberType NoteProperty -Name "$($letter)Status" -Value $true
        }
    }
    $pt1GroupAnswers | Add-Member -MemberType NoteProperty -Name "anyoneAnswerCount" -Value $pt1AnswerArray.Count
    $anyAnswersPerGroup.Add($pt1GroupAnswers) | Out-Null
    $pt2GroupAnswers | Add-Member -MemberType NoteProperty -Name "everyoneAnswerCount" -Value $pt2AnswerArray.Count
    $everyAnswersPerGroup.Add($pt2GroupAnswers) | Out-Null
    ##Write-Verbose -Message "Pt 1 Group ID [$($int)] a [$($a)] b [$($b)] c [$($c)] x [$($x)] y [$($y)] z [$($z)]"
    ##Write-Verbose -Message "Pt 2 Group ID [$($int)] a [$($a)] b [$($b)] c [$($c)] x [$($x)] y [$($y)] z [$($z)]"
}

$pt1Answer = $anyAnswersPerGroup | Measure-Object -Property anyoneAnswerCount -Sum
$pt2Answer = $everyAnswersPerGroup | Measure-Object -Property everyoneAnswerCount -Sum
Write-Warning -Message "Pt 1 Answer is $($pt1Answer.Sum)"
Write-Warning -Message "Pt 2 Answer is $($pt2Answer.Sum)"
##$anyAnswersPerGroup | Out-GridView
##$everyAnswersPerGroup | Out-GridView
##$parsedData | Out-GridView

$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."

##WARNING: Lines of Data [2283] People [1787] Groups [497]
##WARNING: Pt 1 Answer is 7120
##WARNING: Pt 2 Answer is 3570
##WARNING: Script took 8.397571 seconds to run.