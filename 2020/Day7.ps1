#####################
####debug info
#####################
$VerbosePreference = "Continue"##SilentlyContinue,Continue
$WarningPreference = "Continue"
$DebugPreference = "Continue"
$ErrorActionPreference = "Continue"
$InformationPreference = "Continue"
#####################
####variables
#####################
$dataPath = ".\2020\Day7.txt"
$data = Get-Content -Path $dataPath
[System.Collections.ArrayList]$parsedData = @()
[int]$lineCounter = 0##lines in the txt file
$startTime = Get-Date

#####################
####Parse Data
#####################
foreach ($line in $data)
{
    $lineCounter++
    $replacedLine = $line -replace " bags","" -replace " bag","" -replace "\.",""
    $bag, $bagCanHold = $replacedLine.Split(" contain ")
    $bagCanHold = $bagCanHold.Split(", ")
    Write-Verbose -Message "Bag [$($bag)] Can Hold Count [$($bagCanHold.Count)] Can Hold List [$($bagCanHold)]"
    foreach ($childItem in $bagCanHold)
    {
        if ($childItem -eq "no other")
        {
            $count = 0; $bagKind = ""
        }
        else
        {
            $count,$bagKind = $childItem -split " ",2
        }

        $bagData = [PSCustomObject]@{
            line = $lineCounter
            parentBag = $bag
            count = [int]$count
            childBag = $bagKind
            rawdata = $line
        }
        $parsedData.Add($bagData) | Out-Null
    }
}
##$parsedData | Out-GridView
#####################
####Loop Through for Parent Child Relationship Counts for Shiny gold bags
#####################
$pt1Answer = @()
[System.Collections.ArrayList]$pt1AnswerArray = @()
$pt1Search = "shiny gold"
$doneSearching = $false
$timesThrough = 0
$pt1AnswerCount = 0
do
{
    $timesThrough++
    foreach ($row in $parsedData)
    {
        
        if ($row | Where-Object {$_.childBag -in $pt1Search})
        {
            $bagPermutations = [PSCustomObject]@{
                iteration = $timesThrough
                parentBag = $row.parentBag
                count = $row.count
                childBag = $row.childBag
            }
            ####uniqueness doesn't matter
            ##$pt1Answer +=$row.parentBag
            ##if uniquness ends up mattering
            if ($pt1Answer.Contains($row.parentBag))
            {
                ##already in the array. Skip
            }
            else
            {
                $pt1Answer += $row.parentBag
                $pt1AnswerArray.Add($bagPermutations) | Out-Null
            }
        }
        ##if ($row.line -eq 124) {break}
        ####Shiny Gold Child Test Cases
        ##118,124,255,462,470,572
        ####Shiny Gold Parent Test Cases
        ##522
    }
    
    Write-Verbose -Message "Iteration $($timesThrough) Count $($pt1Answer.Count)"
    if ($pt1AnswerCount -eq $pt1Answer.Count) {$doneSearching = $true}
    $pt1AnswerCount = $pt1Answer.Count
    $pt1Search = $pt1Answer
    ##if ($timesThrough -eq 15) {$doneSearching = $true}
} while ($doneSearching -eq $false)
##$pt1AnswerArray | Out-GridView shiny gold
Write-Warning -Message  "Pt 1 Answer. How many bag colors can eventually contain at least one shiny gold bag? [$($pt1Answer.Count)]" #151 is correct

$pt2Search = "shiny gold"
[System.Collections.ArrayList]$pt2AnswerArray = @()
$pt2AnswerCount = 0
$pt2Counter = 0
$doneSearching = $false
$timesThrough = 0
do
{
    $pt2Answer = @()
    $timesThrough++
    $results = $parsedData | Where-Object {$_.parentBag -in $pt2Search}
    foreach ($result in $results)
    {
        $bagPermutations = [PSCustomObject]@{
            iteration = $timesThrough
            parentBag = $result.parentBag
            count = $result.count
            childBag = $result.childBag
        }
        $pt2Counter++
        $pt2Answer += $result.childBag
        $pt2AnswerArray.Add($bagPermutations) | Out-Null
    }
    if ($pt2AnswerCount -eq $pt2AnswerArray.Count) {$doneSearching = $true}
    $pt2AnswerCount = $pt2Counter
    $pt2Search = $pt2Answer
    ##if ($timesThrough -eq 5) {$doneSearching = $true}
    Write-Verbose -Message "Iteration $($timesThrough)"
} while ($doneSearching -eq $false)
##$pt2AnswerArray | Out-GridView

##shiny gold
##muted fuchsia
##clear silver
$doneSearching = $false
$search = @("shiny gold")
[System.Collections.ArrayList]$pt2AnswerArray = @()
$timesThrough = 0
$multiplyNumber = 0
$multiplyBy = 0
$sumArray = @()
do
{
    
    ########to do 
    ####update code based on logic below.
    ####I've been iterating through the parsed data like it's gospel. If a parent bag is on 2 lines, it's still 1 bag.
    ####instead of looping through rows need to be doing lines.
    $timesThrough++
    ##Write-Verbose -Message "timesThrough [$($timesThrough)] search $($search)"
    $selectedRows = $parsedData | Where-Object {$_.parentBag -in $search}
    $search = @()
    if ($timesThrough -eq 1) {$multiplyBy = 1;}
    foreach ($row in $selectedRows)
    {
        $bagPermutations = [PSCustomObject]@{
            parentBag = $row.parentBag
            count = $row.count
            childBag = $row.childBag
        }
        if ($timesThrough -ne 1)
        {
            [int]$multiplyBy = ($pt2AnswerArray | Where-Object {$_.childBag -in $row.parentBag} | Select-Object -ExpandProperty count)
        }
        $multiple = $row.count * $multiplyBy
        for ($int = 1; $int -le $multiple;$int++)
        {
            $pt2AnswerArray.Add($bagPermutations) | Out-Null
        }
        ##$multiplyBy = $row.count
        ##$sumArray += $row.count * $multiplyBy
        ##$multiplyBy = $row.count * $multiplyBy
        ##$sumArray += $row.count
        ##$multiplyNumber += ($row.count *  ($parsedData | Where-Object {$_.parentBag -eq $row.childBag} | Measure-Object -Property count -Sum).Sum)
        ##$search += $parsedData | Where-Object {$_.parentBag -in $row.childBag -and $_.count -ne 0} | Select-Object -ExpandProperty parentBag -Unique
        ##Write-Verbose -Message "Row [$($row)] sumarray [$(($sumArray | Measure-Object -Sum).Sum)] multiplynumber [$($multiplyNumber)]"
        ##Write-Verbose -Message "Search $($search)"
    }

    $search += $parsedData | Where-Object {$_.parentBag -in $row.childBag -and $_.count -ne 0} | Select-Object -ExpandProperty parentBag -Unique
    Write-Verbose -Message "$($multiplyBy) $($row.parentBag) times $($row.count) $($row.childBag) equals $($multiplyBy * $row.count)"
    Write-Verbose -Message "search [$($search)] timesThrough $($timesThrough)"
    if ($timesThrough -eq 8) {$doneSearching = $true}
}while ($doneSearching -eq $false)
$multiplyNumber + ($sumArray | Measure-Object -Sum).Sum

##$pt2AnswerArray | Out-GridView
##$parsedData | Out-GridView

##shiny gold bags contain 2 dark red bags.      1 shiny gold * 2 dark red       = 2 dark red
##dark red bags contain 2 dark orange bags.     2 dark red * 2 dark orange      = 4 dark orange
##dark orange bags contain 2 dark yellow bags.  4 dark orange * 2 dark yellow   = 8 dark yellow
##dark yellow bags contain 2 dark green bags.   8 dark yellow * 2 dark green    = 16 dark green
##dark green bags contain 2 dark blue bags.     16 dark green * 2 dark blue     = 32 dark blue
##dark blue bags contain 2 dark violet bags.    32 dark blue * 2 dark violet    = 64 dark violet
##dark violet bags contain no other bags.



##function Day7-GetPt2Count
##{
##    param
##    (
##        $object,
##        $search
##    )
##    $selectedData = $object | Where-Object {$_.parentBag -eq $search}
##    foreach ($row in $selectedData)
##    {
##        Write-Verbose -Message "$($row)"
##        ##Write-Verbose -Message "Iteration [$($row.iteration)] Parent [$($row.parentBag)] Count [$($row.count)] row.ChildBag [$($row.childBag)] Search [$($search)] SelectedDataCount [$($selectedData.Count)]"
##        Day7-GetPt2Count -object $object -search $row.childBag
##    }
##    return $contains
##}
##
##$total = Day7-GetPt2Count -object $pt2AnswerArray -search "shiny gold"
##$total | Measure-Object -Sum
##$timesThrough = 0
##foreach ($item in $pt2Answer)
##{
##    do
##    {
##        
##        $timesThrough++
##        if ($timesThrough -eq 5) {$doneSearching = $true}
##    }while ($doneSearching -eq $false)
##}

##$pt2Answer##more than 448, more than 797, more than 24655
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."