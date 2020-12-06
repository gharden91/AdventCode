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
for ($int=$minGroupID; $int -le $maxGroupID; $int++)
{
    $answerArray = @()
    $a = $false
    $b = $false
    $c = $false
    $d = $false
    $e = $false
    $f = $false
    $g = $false
    $h = $false
    $i = $false
    $j = $false
    $k = $false
    $l = $false
    $m = $false
    $n = $false
    $o = $false
    $p = $false
    $q = $false
    $r = $false
    $s = $false
    $t = $false
    $u = $false
    $v = $false
    $w = $false
    $x = $false
    $y = $false
    $z = $false
    $selectedData = $parsedData | Where-Object {$_.groupID -eq $int}
    if ($selectedData.rawdata | Select-String -Pattern "a" -SimpleMatch) {$a = $true;$answerArray += "a"}
    if ($selectedData.rawdata | Select-String -Pattern "b" -SimpleMatch) {$b = $true;$answerArray += "b"}
    if ($selectedData.rawdata | Select-String -Pattern "c" -SimpleMatch) {$c = $true;$answerArray += "c"}
    if ($selectedData.rawdata | Select-String -Pattern "d" -SimpleMatch) {$d = $true;$answerArray += "d"}
    if ($selectedData.rawdata | Select-String -Pattern "e" -SimpleMatch) {$e = $true;$answerArray += "e"}
    if ($selectedData.rawdata | Select-String -Pattern "f" -SimpleMatch) {$f = $true;$answerArray += "f"}
    if ($selectedData.rawdata | Select-String -Pattern "g" -SimpleMatch) {$g = $true;$answerArray += "g"}
    if ($selectedData.rawdata | Select-String -Pattern "h" -SimpleMatch) {$h = $true;$answerArray += "h"}
    if ($selectedData.rawdata | Select-String -Pattern "i" -SimpleMatch) {$i = $true;$answerArray += "i"}
    if ($selectedData.rawdata | Select-String -Pattern "j" -SimpleMatch) {$j = $true;$answerArray += "j"}
    if ($selectedData.rawdata | Select-String -Pattern "k" -SimpleMatch) {$k = $true;$answerArray += "k"}
    if ($selectedData.rawdata | Select-String -Pattern "l" -SimpleMatch) {$l = $true;$answerArray += "l"}
    if ($selectedData.rawdata | Select-String -Pattern "m" -SimpleMatch) {$m = $true;$answerArray += "m"}
    if ($selectedData.rawdata | Select-String -Pattern "n" -SimpleMatch) {$n = $true;$answerArray += "n"}
    if ($selectedData.rawdata | Select-String -Pattern "o" -SimpleMatch) {$o = $true;$answerArray += "o"}
    if ($selectedData.rawdata | Select-String -Pattern "p" -SimpleMatch) {$p = $true;$answerArray += "p"}
    if ($selectedData.rawdata | Select-String -Pattern "q" -SimpleMatch) {$q = $true;$answerArray += "q"}
    if ($selectedData.rawdata | Select-String -Pattern "r" -SimpleMatch) {$r = $true;$answerArray += "r"}
    if ($selectedData.rawdata | Select-String -Pattern "s" -SimpleMatch) {$s = $true;$answerArray += "s"}
    if ($selectedData.rawdata | Select-String -Pattern "t" -SimpleMatch) {$t = $true;$answerArray += "t"}
    if ($selectedData.rawdata | Select-String -Pattern "u" -SimpleMatch) {$u = $true;$answerArray += "u"}
    if ($selectedData.rawdata | Select-String -Pattern "v" -SimpleMatch) {$v = $true;$answerArray += "v"}
    if ($selectedData.rawdata | Select-String -Pattern "w" -SimpleMatch) {$w = $true;$answerArray += "w"}
    if ($selectedData.rawdata | Select-String -Pattern "x" -SimpleMatch) {$x = $true;$answerArray += "x"}
    if ($selectedData.rawdata | Select-String -Pattern "y" -SimpleMatch) {$y = $true;$answerArray += "y"}
    if ($selectedData.rawdata | Select-String -Pattern "z" -SimpleMatch) {$z = $true;$answerArray += "z"}
    Write-Verbose -Message "Pt 1 Group ID [$($int)] a [$($a)] b [$($b)] c [$($c)] x [$($x)] y [$($y)] z [$($z)]"
    $groupAnswers = [PSCustomObject]@{
        groupID = $int
        aStatus = $a
        bStatus = $b
        cStatus = $c
        dStatus = $d
        eStatus = $e
        fStatus = $f
        gStatus = $g
        hStatus = $h
        iStatus = $i
        jStatus = $j
        kStatus = $k
        lStatus = $l
        mStatus = $m
        nStatus = $n
        oStatus = $o
        pStatus = $p
        qStatus = $q
        rStatus = $r
        sStatus = $s
        tStatus = $t
        uStatus = $u
        vStatus = $v
        wStatus = $w
        xStatus = $x
        yStatus = $y
        zStatus = $z
        anyoneAnswerCount = [int]$answerArray.Count##pt1 is to sum this
    }
    $anyAnswersPerGroup.Add($groupAnswers) | Out-Null
}

$pt1Answer = $anyAnswersPerGroup | Measure-Object -Property anyoneAnswerCount -Sum
##$anyAnswersPerGroup | Out-GridView
Write-Warning -Message "Pt 1 Answer is $($pt1Answer.Sum)"

[System.Collections.ArrayList]$everyAnswersPerGroup = @()
for ($int=$minGroupID; $int -le $maxGroupID; $int++)
{
    $answerArray = @()
    $a = $false
    $b = $false
    $c = $false
    $d = $false
    $e = $false
    $f = $false
    $g = $false
    $h = $false
    $i = $false
    $j = $false
    $k = $false
    $l = $false
    $m = $false
    $n = $false
    $o = $false
    $p = $false
    $q = $false
    $r = $false
    $s = $false
    $t = $false
    $u = $false
    $v = $false
    $w = $false
    $x = $false
    $y = $false
    $z = $false
    $selectedData = $parsedData | Where-Object {$_.groupID -eq $int}
    $peopleInGroup = $selectedData.Count
    if (($selectedData.rawdata | Select-String -Pattern "a").Matches.Count -eq $peopleInGroup) {$a = $true;$answerArray += "a"}
    if (($selectedData.rawdata | Select-String -Pattern "b").Matches.Count -eq $peopleInGroup) {$b = $true;$answerArray += "b"}
    if (($selectedData.rawdata | Select-String -Pattern "c").Matches.Count -eq $peopleInGroup) {$c = $true;$answerArray += "c"}
    if (($selectedData.rawdata | Select-String -Pattern "d").Matches.Count -eq $peopleInGroup) {$d = $true;$answerArray += "d"}
    if (($selectedData.rawdata | Select-String -Pattern "e").Matches.Count -eq $peopleInGroup) {$e = $true;$answerArray += "e"}
    if (($selectedData.rawdata | Select-String -Pattern "f").Matches.Count -eq $peopleInGroup) {$f = $true;$answerArray += "f"}
    if (($selectedData.rawdata | Select-String -Pattern "g").Matches.Count -eq $peopleInGroup) {$g = $true;$answerArray += "g"}
    if (($selectedData.rawdata | Select-String -Pattern "h").Matches.Count -eq $peopleInGroup) {$h = $true;$answerArray += "h"}
    if (($selectedData.rawdata | Select-String -Pattern "i").Matches.Count -eq $peopleInGroup) {$i = $true;$answerArray += "i"}
    if (($selectedData.rawdata | Select-String -Pattern "j").Matches.Count -eq $peopleInGroup) {$j = $true;$answerArray += "j"}
    if (($selectedData.rawdata | Select-String -Pattern "k").Matches.Count -eq $peopleInGroup) {$k = $true;$answerArray += "k"}
    if (($selectedData.rawdata | Select-String -Pattern "l").Matches.Count -eq $peopleInGroup) {$l = $true;$answerArray += "l"}
    if (($selectedData.rawdata | Select-String -Pattern "m").Matches.Count -eq $peopleInGroup) {$m = $true;$answerArray += "m"}
    if (($selectedData.rawdata | Select-String -Pattern "n").Matches.Count -eq $peopleInGroup) {$n = $true;$answerArray += "n"}
    if (($selectedData.rawdata | Select-String -Pattern "o").Matches.Count -eq $peopleInGroup) {$o = $true;$answerArray += "o"}
    if (($selectedData.rawdata | Select-String -Pattern "p").Matches.Count -eq $peopleInGroup) {$p = $true;$answerArray += "p"}
    if (($selectedData.rawdata | Select-String -Pattern "q").Matches.Count -eq $peopleInGroup) {$q = $true;$answerArray += "q"}
    if (($selectedData.rawdata | Select-String -Pattern "r").Matches.Count -eq $peopleInGroup) {$r = $true;$answerArray += "r"}
    if (($selectedData.rawdata | Select-String -Pattern "s").Matches.Count -eq $peopleInGroup) {$s = $true;$answerArray += "s"}
    if (($selectedData.rawdata | Select-String -Pattern "t").Matches.Count -eq $peopleInGroup) {$t = $true;$answerArray += "t"}
    if (($selectedData.rawdata | Select-String -Pattern "u").Matches.Count -eq $peopleInGroup) {$u = $true;$answerArray += "u"}
    if (($selectedData.rawdata | Select-String -Pattern "v").Matches.Count -eq $peopleInGroup) {$v = $true;$answerArray += "v"}
    if (($selectedData.rawdata | Select-String -Pattern "w").Matches.Count -eq $peopleInGroup) {$w = $true;$answerArray += "w"}
    if (($selectedData.rawdata | Select-String -Pattern "x").Matches.Count -eq $peopleInGroup) {$x = $true;$answerArray += "x"}
    if (($selectedData.rawdata | Select-String -Pattern "y").Matches.Count -eq $peopleInGroup) {$y = $true;$answerArray += "y"}
    if (($selectedData.rawdata | Select-String -Pattern "z").Matches.Count -eq $peopleInGroup) {$z = $true;$answerArray += "z"}
    Write-Verbose -Message "Pt 2 Group ID [$($int)] a [$($a)] b [$($b)] c [$($c)] x [$($x)] y [$($y)] z [$($z)]"
    $groupAnswers = [PSCustomObject]@{
        groupID = $int
        aStatus = $a
        bStatus = $b
        cStatus = $c
        dStatus = $d
        eStatus = $e
        fStatus = $f
        gStatus = $g
        hStatus = $h
        iStatus = $i
        jStatus = $j
        kStatus = $k
        lStatus = $l
        mStatus = $m
        nStatus = $n
        oStatus = $o
        pStatus = $p
        qStatus = $q
        rStatus = $r
        sStatus = $s
        tStatus = $t
        uStatus = $u
        vStatus = $v
        wStatus = $w
        xStatus = $x
        yStatus = $y
        zStatus = $z
        everyoneAnswerCount = [int]$answerArray.Count##pt1 is to sum this
    }
    $everyAnswersPerGroup.Add($groupAnswers) | Out-Null
}
##$everyAnswersPerGroup | Out-GridView
##$parsedData | Out-GridView
$pt2Answer = $everyAnswersPerGroup | Measure-Object -Property everyoneAnswerCount -Sum
Write-Warning -Message "Pt 2 Answer is $($pt2Answer.Sum)"
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."

##WARNING: Lines of Data [2283] People [1787] Groups [497]
##WARNING: Pt 1 Answer is 7120
##WARNING: Pt 2 Answer is 3570
##WARNING: Script took 16.7712686 seconds to run.