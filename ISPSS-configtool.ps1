# CyberArk Privilege ISPSS Config Tool
$version = "22.09.28"
# Prompt user for ISPSS URL
$ISPSSURL = Read-Host -Prompt 'Input your ISPSSURL eg https://subdomain.cyberark.cloud'

###########################################

function Show-Menu {
    param (
        [string]$Title = 'CyberArk ISPSS Config Tool - Version'
    )
    Clear-Host
    Write-Host "================ $Title $version ================"
    
    Write-Host "1: Press '1' Authenticate to ISPSS"
    Write-Host "2: Press '2' Create Identity Auth Profiles"
    Write-Host "3: Press '3' Create Identity Policies"
    Write-Host "4: Press '4' Pre-Requisties Checklist"
    Write-Host "5: Press '5' Install PSM Health Check"
    Write-Host "6: Press '6' Run PSMConfigureAppLocker Script"
    Write-Host "7: Press '7' Run Move PSMConnect and PSMAdminConnect Script"
    Write-Host "Q: Press 'Q' to quit."
}

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    # Start Option 1        
    Write-Host 'You chose option #1 - Authenticate to ISPSS'
    Write-host $ISPSSURL
    # End Option 1
    ###########################################
    } '2' {
    # Start Option 2        
    Write-Host 'You chose option #2 - Create Identity Auth Profiles'
    # End Option 2
    ###########################################
    } '3' {
    # Start Option 3        
    Write-Host 'You chose option #3 - Create Identity Policies'
    # End Option 3
    ###########################################
    } '4' {
    # Start Option 3        
    Write-Host 'You chose option #4 - Pre-Requisties Checklist'
    # End Option 3
    ###########################################    
    } '5' {
    # Start Option 3        
    Write-Host 'You chose option #5 - Install PSM Health Check'
    # End Option 3
    ###########################################   
    } '6' {
    # Start Option 3        
    Write-Host 'You chose option #6 - Run PSMConfigureAppLocker Script'
    # End Option 3
    ###########################################   
    } '7' {
    # Start Option 3        
    Write-Host 'You chose option #7 - Run Move PSMConnect and PSMAdminConnect Script'
    # End Option 3
    ###########################################
    }
    }
    pause
 }
 until ($selection -eq 'q')


