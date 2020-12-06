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
$dataPath = ".\2020\Day5.csv"
$data = Import-Csv -Path $dataPath
[System.Collections.ArrayList]$parsedData = @()
$startTime = Get-Date
##FFFFBBFRRR
##FFFFBBF   - Describe which row of the 128 row plane (0 to 127). F - Lower Half. B - Upper Half.
##RRR       - Descibe one of the 8 columns of seats (0 to 7). L - Lower Half. R - Upper Half.

##FBFBBFFRLR - seat row 44, column 5
##0-63 lower, 32-63 upper, 32-47 lower, 40-47 upper, 44-47 upper, 44-45 lower, 44 lower
##4-7 upper, 4-5 lower, 5 upper
##seat ID. multiply the row by 8, then add the column.
##44 * 8 + 5 = 357

##FBFBBFFRLR - seat row 44, column 5
##BFFFBBFRRR: row 70, column 7, seat ID 567.
##FFFBBBFRRR: row 14, column 7, seat ID 119.
##BBFFBBFRLL: row 102, column 4, seat ID 820.

##Line 0 GeoffData
##FBFBBBF	RLR	
##Row  Column 5


##Pt1. What is the highest seat ID on a boarding pass?

function Parse-Day5
{
    param
    (
        [string[]]$Directions,
        $range
    )
    $directionsArray = ($Directions.ToCharArray()).ForEach([string])
    Write-Verbose -Message "$($range.Count)"
    ##"$($Directions)_$($range.Count)"
    foreach ($direction in $directionsArray)
    {
        Write-Verbose -Message $direction
        switch ($direction)
        {
            {($_ -eq "R") -or ($_ -eq "B")}##Upper half
            {
                $totalToGet = $range.Count / 2
                $upper = $range | Select-Object -Last 1
                Write-Verbose -Message "Total $($totalToGet) Upper $($upper)"
                $range = $range | Select-Object -Last $totalToGet
            }
            {($_ -eq "L") -or ($_ -eq "F")}##Lower Half
            {
                $totalToGet = $range.Count / 2
                $lower = $range | Select-Object -First 1
                Write-Verbose -Message "Lower $($lower) Total $($totalToGet)"
                $range = $range | Select-Object -First $totalToGet
            }
        }
    }
    return $range
}

###############
####Test Cases
###############
##FBFBBFFRLR - seat row 44, column 5
Write-Warning -Message "FBFBBFFRLR Row $(Parse-Day5 -Directions "FBFBBFF" -range (0..127)) Column $(Parse-Day5 -Directions "RLR" -range (0..7))"
##BFFFBBFRRR: row 70, column 7, seat ID 567.
Write-Warning -Message "BFFFBBFRRR Row $(Parse-Day5 -Directions "BFFFBBF" -range (0..127)) Column $(Parse-Day5 -Directions "RRR" -range (0..7))"
##FFFBBBFRRR: row 14, column 7, seat ID 119.
Write-Warning -Message "FFFBBBFRRR Row $(Parse-Day5 -Directions "FFFBBBF" -range (0..127)) Column $(Parse-Day5 -Directions "RRR" -range (0..7))"
##BBFFBBFRLL: row 102, column 4, seat ID 820.
Write-Warning -Message "BBFFBBFRLL Row $(Parse-Day5 -Directions "BBFFBBF" -range (0..127)) Column $(Parse-Day5 -Directions "RLL" -range (0..7))"

$a = 0
foreach ($line in $data)
{
    $row = Parse-Day5 -Directions "$($line.Data.substring(0,7))" -range (0..127)
    $column = Parse-Day5 -Directions "$($line.Data.substring(7,3))" -range (0..7)
    $boardingPasses = [PSCustomObject]@{
        line = $a
        boardingPassRaw = $line.Data
        rowRaw = $line.Data.substring(0,7)
        columnRaw = $line.Data.substring(7,3)
        rowParsed = $row
        columnParsed = $column
        passCheckSum = $row * 8 + $column
    }
    $a++
    $parsedData.Add($boardingPasses) | Out-Null
    ##if ($a -eq 1){break}
}
$parsedDataDescending = $parsedData | Sort-Object -Property passCheckSum -Descending 
$maxSeatID = $parsedDataDescending | Select-Object -First 1 -ExpandProperty passCheckSum
Write-Warning -Message "Pt 1 Answer Max Seat ID $($maxSeatID )"

$minSeatID = $parsedDataDescending | Select-Object -Last 1 -ExpandProperty passCheckSum

for ($i=$minSeatID; $i -le $maxSeatID; $i++)
{
    if ($parsedData | Where-Object {$_.passCheckSum -eq $i})
    {
        ##Seat is Good
    }
    else
    {
        Write-Warning "Pt 2 Answer My Seat, or the missing Seat ID is [$($i)]"    
    }
}

##$parsedData | Sort-Object -Property passCheckSum -Descending | Out-GridView
##$parsedData | Out-GridView
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."

############
####Output
############
##WARNING: FBFBBFFRLR Row 44 Column 5
##WARNING: BFFFBBFRRR Row 70 Column 7
##WARNING: FFFBBBFRRR Row 14 Column 7
##WARNING: BBFFBBFRLL Row 102 Column 4
##WARNING: Pt1 Answer Max Seat ID 978
##WARNING: Pt 2 Answer My Seat, or the missing Seat ID is [727]
##WARNING: Script took 7.9520585 seconds to run.