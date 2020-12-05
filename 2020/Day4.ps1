#####################
####variables
#####################
$VerbosePreference = "SilentlyContinue"##SilentlyContinue,Continue
$WarningPreference = "Continue"
$DebugPreference = "Continue"
$ErrorActionPreference = "Continue"
$InformationPreference = "Continue"
#####################
####debug info
#####################
$dataPath = ".\2020\Day4.txt"
$data = Get-Content -Path $dataPath
[System.Collections.ArrayList]$parsedData = @()
[int]$lineCounter = 0##lines in the txt file
[int]$dataCounter = 1##lines of logical csv data
$startTime = Get-Date
$pt1SuccessData = @()
$pt1BadData = @()
$pt2SuccessData = @()
$pt2BadData = @()
$goodAndValid = @()
##byr (Birth Year)
##iyr (Issue Year)
##eyr (Expiration Year)
##hgt (Height)
##hcl (Hair Color)
##ecl (Eye Color)
##pid (Passport ID)
##cid (Country ID) - optional

#####################
####Parse the Data
#####################
foreach ($line in $data)
{
    $lineCounter++
    if ($line -eq "")
    {
        $dataCounter++
        Continue
    }
    $tmpLine = $line.Split(" ")
    ##$tmpLine = $line.Split(":")
    ##Write-Verbose -Message "Count $($tmpLine.Count)"
    foreach ($item in $tmpLine)
    {
        Write-Verbose -Message "$($item)"
        $tmpItem = $item.Split(":")
        $passportObject = [PSCustomObject]@{
            name = $tmpItem[0]
            value = $tmpItem[1]
            line = $lineCounter
            dataID = $dataCounter
        }
        $parsedData.Add($passportObject) | Out-Null
    }
    ##if ($lineCounter -eq 20) {break}
}
#####################
####Pt1 & 2 code
#####################
for (($x=1); $x -le $dataCounter; ($x++))
##for (($x=58); $x -eq 58; ($x++))
{
    $value = Out-Null
    $message = @()
    $dataFormatValid = @()
    $selectedData = $parsedData | Where-Object {$_.dataID -eq $x}
    if (-Not ($selectedData | Where-Object {$_.name -eq "byr"}))
    {
        $message += "Missing Birth Year"
        $dataFormatValid += "Missing Birth Year"
    }
    else
    {
        $value = $selectedData | Where-Object {$_.name -eq "byr"} | Select-Object -ExpandProperty value
        if ($value -as [int])
        {
            $value = [int]$value
            ##1920 and at most 2002
            $test = 1920..2002
            if ($test.Contains($value)) {Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Format Good For Birth Year"}
            else {$dataFormatValid += "Birth Year Format Bad"}
        }
    }
    if (-Not ($selectedData | Where-Object {$_.name -eq "iyr"}))
    {
        $message += "Missing Issue Year"
        $dataFormatValid += "Missing Issue Year"
    }
    else
    {
        $value = $selectedData | Where-Object {$_.name -eq "iyr"} | Select-Object -ExpandProperty value
        if ($value -as [int])
        {
            $value = [int]$value
            ##2010 and at most 2020
            $test = 2010..2020
            if ($test.Contains($value)) {Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Format Good For Issue Year"}
            else {$dataFormatValid += "Issue Year Format Bad"}
        }
    }
    if (-Not ($selectedData | Where-Object {$_.name -eq "eyr"}))
    {
        $message += "Missing Expiration Year"
        $dataFormatValid += "Missing Expiration Year"
    }
    else
    {
        $value = $selectedData | Where-Object {$_.name -eq "eyr"} | Select-Object -ExpandProperty value
        if ($value -as [int])
        {
            $value = [int]$value
            ##2020 and at most 2030
            $test = 2020..2030
            if ($test.Contains($value)) {Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Format Good For Expiration Year"}
            else {$dataFormatValid += "Expiration Year Format Bad"}
        }
    }
    if (-Not ($selectedData | Where-Object {$_.name -eq "hgt"}))
    {
        $message += "Missing Height"
        $dataFormatValid += "Missing Height"
    }
    else
    {
        $measureType = ""
        $value = $selectedData | Where-Object {$_.name -eq "hgt"} | Select-Object -ExpandProperty value
        if ($value | Select-String -SimpleMatch -Pattern "cm") {$measureType = "cm";$value = $value -replace "cm";$test = 150..193}
        elseif ($value | Select-String -SimpleMatch -Pattern "in") {$measureType = "in";$value = $value -replace "in";$test = 59..76}
        else {$dataFormatValid += "Height does not have cm or in"}
        $value = [int]$value
        if ($test.Contains($value)) {Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Format Good For Height"}
        else {$dataFormatValid += "Height outside of range"}
    }
    if (-Not ($selectedData | Where-Object {$_.name -eq "hcl"}))
    {
        $message += "Missing Hair Color"
        $dataFormatValid += "Missing Hair Color"
    }
    else
    {
        $alphaRange = "a".."f"
        $numRange = "0","1","2","3","4","5","6","7","8","9"
        $value = $selectedData | Where-Object {$_.name -eq "hcl"} | Select-Object -ExpandProperty value
        $hairArray = $value.ToCharArray()
        $charArrayCounter = 0
        $validCharacterCounter = 0
        foreach ($char in $hairArray)
        {
            if ($charArrayCounter -eq 0)
            {
                if ($char -eq "#")
                {
                    ##got here
                    $charArrayCounter++;
                }
                else
                {
                    $dataFormatValid += "Hair Color does not start with #";
                    $charArrayCounter++;
                    ##continue
                }
            }
            else
            {
                ##$char.GetType()
                ##$numRange[0].GetType()
                if ($alphaRange.Contains($char) -or $numRange.Contains($char -as [string]))
                {
                    $validCharacterCounter++
                    $charArrayCounter++
                }
                else
                {
                    $dataFormatValid += "Hair Color Character [$($char)] is not in range."
                    $charArrayCounter++
                    ##continue
                }
            }
        }
        if ($validCharacterCounter -eq 6 -and $dataFormatValid -eq $true) {Write-Verbose -Message "Format Good Hair Color"}
    }
    if (-Not ($selectedData | Where-Object {$_.name -eq "ecl"}))
    {
        $message += "Missing Eye Color"
        $dataFormatValid += "Missing Eye Color"
    }
    else
    {
        $value = $selectedData | Where-Object {$_.name -eq "ecl"} | Select-Object -ExpandProperty value
        $test = 'amb','blu','brn','gry','grn','hzl','oth'
        if ($test.Contains($value)) {Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Format Good For Eye Color"}
        else {$dataFormatValid += "Eye color not in list [$($value)]"}
    }
    if (-Not ($selectedData | Where-Object {$_.name -eq "pid"}))
    {
        $message += "Missing Passport ID"
        $dataFormatValid += "Missing Passport ID"
    }
    else
    {
        $value = $selectedData | Where-Object {$_.name -eq "pid"} | Select-Object -ExpandProperty value
        if ($value -as [int] -and $value.Length -eq 9)
        {
            Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Format Good For Passport ID"
        }
        else {$dataFormatValid += "Passport Number Format Bad"}
    }
    if (-Not ($selectedData | Where-Object {$_.name -eq "cid"}))
    {
        $message += "Missing Contry ID"
    }
    $dataFormatValidCount = $dataFormatValid.Count
    $messageArrayCount = $message.Count
    
    $pt1Success = $false
    $pt2Success = $false
    if ($message.Count -ge 1)
    {
        if ($message.Contains("Missing Contry ID")) {$messageArrayCount--}
        ##Write-Verbose -Message "$($x) DataID [$($selectedData.dataID[0])] There are [$($message.Count)] errors. Adjusted Errors [$($messageArrayCount)] Message [$($message)]"
        if ($messageArrayCount -eq 0)
        {
            $pt1SuccessData += $selectedData | Select-Object -First 1
            Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Passport Missing No Data"
            $pt1Success = $true
        }
        else
        {
            $pt1BadData += $selectedData | Select-Object -First 1
            Write-Warning -Message "DataID [$($selectedData.dataID[0])] Passport Missing [$($message)]"  
        }
    }
    else
    {
        $pt1SuccessData += $selectedData | Select-Object -First 1
        $pt1Success = $true
        Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Passport Missing No Data"    
    }

    if (-Not $dataFormatValid.Count -ge 1)
    {
        $pt2SuccessData += $selectedData | Select-Object -First 1
        $pt2Success = $true
        Write-Verbose -Message "DataID [$($selectedData.dataID[0])] Passport Format Good"
    }
    else
    {
        $pt2BadData += $selectedData | Select-Object -First 1
        Write-Warning -Message "DataID [$($selectedData.dataID[0])] Passport Format Bad [$($dataFormatValid)]"
    }
    if ($pt1Success -eq $true -and $pt2Success -eq $true) {$goodAndValid += $selectedData | Select-Object -First 1}
}
##$pt1SuccessData | Out-GridView
##$pt1BadData | Out-GridView
##$pt2BadData | Out-GridView
##$parsedData | Out-GridView
##$goodAndValid | Out-GridView
Write-Warning -Message "Pt 1 Bad Passports $($pt1BadData.Count)"
Write-Warning -Message "Pt 1 Good Passports $($pt1SuccessData.Count)"
Write-Warning -Message "Pt 2 Bad Passports $($pt2BadData.Count)"
Write-Warning -Message "Pt 2 Good Passports $($pt2SuccessData.Count)"
Write-Warning -Message "Pt 2 Good AND Valid Passports $($goodAndValid.Count)"
Write-Warning -Message "Total Data $($dataCounter)"

$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime
Write-Warning -Message "Script took $($duration.TotalSeconds) seconds to run."
##WARNING: Pt 1 Bad Passports 66
##WARNING: Pt 1 Good Passports 210
##WARNING: Pt 2 Bad Passports 145
##WARNING: Pt 2 Good Passports 131
##WARNING: Pt 2 Good AND Valid Passports 131
##WARNING: Total Data 276
##WARNING: Script took 9.7894053 seconds to run.