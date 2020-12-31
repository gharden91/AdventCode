#####################
####debug info
#####################
$VerbosePreference = "Continue"##SilentlyContinue,Continue
$WarningPreference = "Continue"
$DebugPreference = "Continue"
$ErrorActionPreference = "Continue"
$InformationPreference = "Continue"
$startTime = Get-Date
#####################
####variables
#####################
##$dataPath = ".\2020\Day8.csv"
$dataPath = ".\2020\Day8Test1.csv"
$data = Import-Csv -Path $dataPath -Delimiter " " -Header "operation","argument"
######  operations
######      -acc. increase or decrease global accumulator by value given. Starts at 0
######          go to next instruction set after acc
######          -ex acc +7 increases it by 7.
######      -jmp. jumps to new instruction relative to itself. Next one is found as an offset from the current instruction.
######          -ex jmp +2 skips the next instruction, jmp +1 goes to the next one like normal, jmp -20 goes 20 lines above to be executed next
#####       -nop. No Operations. Does nothing. Just goes to the next instruction.

####arguments
######signed number like +4 or -20
[int]$accumulator = 0
$linesVisited = @()
[int]$line = 0
$repeatedLine = $false
do
{
    $currentOperation = $data[$line].operation
    $currentArgument  = [int]$data[$line].argument
    switch ($currentOperation)
    {
        "nop"
        {
            $linesVisited += $line
            Write-Verbose -Message "Line $($line)   $($currentOperation)    $($currentArgument)"
            $line++
        }
        "acc"
        {
            $newAccumulator = $accumulator + $currentArgument
            $linesVisited += $line
            Write-Verbose -Message "Line $($line)   $($currentOperation)    $($currentArgument) Current Accumulator $($accumulator) Adding $($currentArgument) New Accumulator $($newAccumulator)"
            $line++
            $accumulator = $newAccumulator
        }
        "jmp"
        {
            $linesVisited += $line
            Write-Verbose -Message "Line $($line)   $($currentOperation)    $($currentArgument) Jumping $($currentArgument)"
            $line = $line + $currentArgument
        }
        Default
        {
            Write-Error -Message "Line $($line) ERROR"
        }
    }
    if ($line -in $linesVisited) {$repeatedLine = $true}
} while ($repeatedLine -eq $false)
Write-Verbose -Message "Pt 1. Lines Visited $($linesVisited.Length) Current Accumulator $($accumulator)"
####VERBOSE: Lines Visited 200 Current Accumulator 1586