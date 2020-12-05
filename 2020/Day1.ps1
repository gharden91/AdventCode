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
$dataPath = ".\2020\Day1.csv"
$data = Import-Csv -Path $dataPath
$startTime = Get-Date
############################
foreach ($line1 in $data)
{
    foreach ($line2 in $data)
    {
        #####################
        ####code for part 1
        #####################
        [int]$sumAnswerPt1 = [int]$line1.Data + [int]$line2.Data
        if ($sumAnswerPt1 -eq 2020)
        {
            [int]$multiplyAnswerPt1 = [int]$line1.Data * [int]$line2.Data
            Write-Warning -Message "Line1 $($line1.Data) Line2 $($line2.Data) sumAnswerPt1 [$($sumAnswerPt1)] multiplyAnswerPt1 [$($multiplyAnswerPt1)]"
        }
        Write-Verbose -Message "Line1 $($line1.Data) Line2 $($line2.Data) sumAnswerPt1 [$($sumAnswerPt1)]"
        #####################
        ####code for part 2
        #####################
        foreach ($line3 in $data)
        {
            [int]$sumAnswerPt2 = [int]$line1.Data + [int]$line2.Data + [int]$line3.Data
            if ($sumAnswerPt2 -eq 2020)
            {
                [int]$multiplyAnswerPt2 = [int]$line1.Data * [int]$line2.Data * [int]$line3.Data
                Write-Warning -Message "Line1 $($line1.Data) Line2 $($line2.Data) Line3 $($line3.Data) sumAnswerPt2 [$($sumAnswerPt2)] multiplyAnswerPt2 [$($multiplyAnswerPt2)]"
            }
            Write-Verbose -Message "Line1 $($line1.Data) Line2 $($line2.Data) Line3 $($line3.Data) sumAnswerPt2 [$($sumAnswerPt2)]"
        }
    }
}
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."
#####################
####Output will look like this
#####################
##WARNING: Line1 1065 Line2 368 Line3 587 sumAnswerPt2 [2020] multiplyAnswerPt2 [230057040]
##WARNING: Line1 1065 Line2 587 Line3 368 sumAnswerPt2 [2020] multiplyAnswerPt2 [230057040]
##WARNING: Line1 1236 Line2 784 sumAnswerPt1 [2020] multiplyAnswerPt1 [969024]
##WARNING: Line1 368 Line2 1065 Line3 587 sumAnswerPt2 [2020] multiplyAnswerPt2 [230057040]
##WARNING: Line1 368 Line2 587 Line3 1065 sumAnswerPt2 [2020] multiplyAnswerPt2 [230057040]
##WARNING: Line1 587 Line2 1065 Line3 368 sumAnswerPt2 [2020] multiplyAnswerPt2 [230057040]
##WARNING: Line1 587 Line2 368 Line3 1065 sumAnswerPt2 [2020] multiplyAnswerPt2 [230057040]
##WARNING: Line1 784 Line2 1236 sumAnswerPt1 [2020] multiplyAnswerPt1 [969024]
##WARNING: Script took 211.806495 to run.