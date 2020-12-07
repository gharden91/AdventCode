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
##$pt1AnswerArray | Out-GridView
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


function Day7-GetContent
{
    param
    (
        $object,
        $search
    )
    $selectedData = $object | Where-Object {$_.parentBag -eq $search}
    [int]$contains = [int]$contains + [int]$selectedData.Count
    foreach ($row in $selectedData)
    {
        Write-Verbose -Message "Search [$($search)] Contains [$($contains)] SelectedDataCount [$($selectedData.Count)] row.ChildBag [$($row.childBag)]"
        Day7-GetContent -object $object -search $row.childBag
    }
    return $contains
}

$total = Day7-GetContent -object $pt2AnswerArray -search "shiny gold"
$total | Measure-Object -Sum
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

##$pt2Answer##more than 448, more than 24655
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."