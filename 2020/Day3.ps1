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
$dataPath = ".\2020\Day3.txt"
$data = Get-Content -Path $dataPath
$parsedData = @()
$parsedDataRowCount = 0
$startTime = Get-Date
$pt1SuccessData = 0
$pt2aSuccessData = 0
##$pt2bSuccessData = @()
$pt2cSuccessData = 0
$pt2dSuccessData = 0
$pt2eSuccessData = 0
foreach ($line in $data)
{
    $parsedData += "$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)$($line)"
    $parsedDataRowCount++
}
[int]$x = 0
#####################
####pt1 code right 3 down 1
#####################
for (($line=0),($x = 0); $line -lt $parsedDataRowCount; ($line ++), ($x+=3))
{
   Write-Verbose -Message "$($line)-$($x) $($parsedData[$line].Substring($x,1))"
   if ($parsedData[$line].Substring($x,1) -eq "#") {$pt1SuccessData++}
}
Write-Warning -Message "Pt 1 and 2b Trees Ran Into $($pt1SuccessData)"
#####################
####pt2 code right 1 down 1
#####################
for (($line=0),($x = 0); $line -lt $parsedDataRowCount; ($line ++), ($x+=1))
{
   Write-Verbose -Message "$($line)-$($x) $($parsedData[$line].Substring($x,1))"
   if ($parsedData[$line].Substring($x,1) -eq "#") {$pt2aSuccessData++}
}
Write-Warning -Message "Pt 2a Trees Ran Into $($pt2aSuccessData)"
#####################
####pt2 code right 5 down 1
#####################
for (($line=0),($x = 0); $line -lt $parsedDataRowCount; ($line ++), ($x+=5))
{
   Write-Verbose -Message "$($line)-$($x) $($parsedData[$line].Substring($x,1))"
   if ($parsedData[$line].Substring($x,1) -eq "#") {$pt2cSuccessData++}
}
Write-Warning -Message "Pt 2c Trees Ran Into $($pt2cSuccessData)"
#####################
####pt2 code right 7 down 1
#####################
for (($line=0),($x = 0); $line -lt $parsedDataRowCount; ($line ++), ($x+=7))
{
   Write-Verbose -Message "$($line)-$($x) $($parsedData[$line].Substring($x,1))"
   if ($parsedData[$line].Substring($x,1) -eq "#") {$pt2dSuccessData++}
}
Write-Warning -Message "Pt 2d Trees Ran Into $($pt2dSuccessData)"
#####################
####pt2 code right 1 down 2
#####################
for (($line=0),($x = 0); $line -lt $parsedDataRowCount; ($line +=2), ($x+=1))
{
   Write-Verbose -Message "$($line)-$($x) $($parsedData[$line].Substring($x,1))"
   if ($parsedData[$line].Substring($x,1) -eq "#") {$pt2eSuccessData++}
}
Write-Warning -Message "Pt 2e Trees Ran Into $($pt2eSuccessData)"
Write-Warning -Message "Pt 2 multiplied together is $($pt2aSuccessData * $pt1SuccessData * $pt2cSuccessData * $pt2dSuccessData * $pt2eSuccessData)"
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."
#####################
####Output
#####################
####WARNING: Pt 1 and 2b Trees Ran Into 220
####WARNING: Pt 2a Trees Ran Into 70
####WARNING: Pt 2c Trees Ran Into 63
####WARNING: Pt 2d Trees Ran Into 76
####WARNING: Pt 2e Trees Ran Into 29
####WARNING: Pt 2 multiplied together is 2138320800