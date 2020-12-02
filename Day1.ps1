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
$dataPath = ".\Day1.csv"
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
##first number 1664
###last number 1943