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
    $bagCanHold = $bagCanHold.Split(",")
    Write-Verbose -Message "Bag [$($bag)] Can Hold Count [$($bagCanHold.Count)] Can Hold List [$($bagCanHold)]"
    $bagData = [PSCustomObject]@{
        line = $lineCounter
        parentBag = $bag
        childBag = $bagCanHold
        rawdata = $line
    }
    $parsedData.Add($bagData) | Out-Null
}
#####################
####Loop Through for Parent Child Relationship Counts for Shiny gold bags
#####################
##$parsedData | Out-GridView
$pt1Answer = @()
$pt1Search = "*shiny gold*"
$doneSearching = $false
$timesThrough = 0
do
{
    foreach ($row in $parsedData)
    {
        if ($row | Where-Object {$_.childBag -like $pt1Search})
        {
            if ($pt1Answer.Contains($row.parentBag))
            {
                ##already in the array. Skip
            }
            else
            {
                $pt1Answer +=$row.parentBag
            }
        }
        ##if ($row.line -eq 124) {break}
        ####Shiny Gold Child Test Cases
        ##118,124,255,462,470,572
        ####Shiny Gold Parent Test Cases
        ##522
    }
    $timesThrough++
    if ($timesThrough -eq 5) {$doneSearching = $true}
} while ($doneSearching -eq $false)
$pt1Answer
$timesThrough