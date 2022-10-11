Import-Module "$($PSScriptRoot)\modules\Pester\5.3.3\Pester.psm1"

Invoke-Pester -Path "$($PSScriptRoot)\tests"