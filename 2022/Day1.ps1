$testData = Get-Content ".\2022\Day1_Test.txt"
$pt1Data = Get-Content ".\2022\Day1_Input.txt"

####how many calories are being carried by the elf carrying the most calories

function Get-AOCSeparateElfCalories {
    param (
        $inputData
    )
    [System.Collections.ArrayList]$parsedData = @()
    $food = @()
    $elfCounter = 1
    for ($i = 0; $i -le $inputData.Count; $i++) {
        if ($inputData[$i] -eq "")
        {
            $dataObject = [PSCustomObject]@{
                elfCounter = $elfCounter
                sumCalories = ($food | Measure-Object -Sum).Sum
                foodCalories = $food
            }
            $parsedData.Add($dataObject) | Out-Null
            $elfCounter++
            $food = @()
        }
        elseif ($i -eq $inputData.Count)
        {
            ##$food += $inputData[$i]
            $dataObject = [PSCustomObject]@{
                elfCounter = $elfCounter
                sumCalories = ($food | Measure-Object -Sum).Sum
                foodCalories = $food
            }
            $parsedData.Add($dataObject) | Out-Null
            $elfCounter++
            $food = @()
        }
        else
        {
            $food += $inputData[$i]
        }
    }
    $parsedData
}

####testData
Get-AOCSeparateElfCalories -input $testData | Sort-Object -Property sumCalories -Descending | Select-Object -First 1

####part 1
Get-AOCSeparateElfCalories -input $pt1Data | Sort-Object -Property sumCalories -Descending | Select-Object -First 1

####part 2
(Get-AOCSeparateElfCalories -input $pt1Data | Sort-Object -Property sumCalories -Descending | Select-Object -First 3 | Measure-Object -Sum -Property sumCalories).Sum