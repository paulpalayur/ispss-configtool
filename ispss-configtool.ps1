# CyberArk Privilege Cloud Service Menu
$version = "21.07.09"
# List all Cyberark Connector/PSM Servers here
$PSMServers = "connector1","connector2"
$CPMServers = "connector1"
$SecureTunnelServers = "connector1","connector2"
###########################################

function Show-Menu {
    param (
        [string]$Title = 'CyberArk Privilege Cloud Service Menu - Version'
    )
    Clear-Host
    Write-Host "================ $Title $version ================"
    
    Write-Host "1: Press '1' for PSM service restart on all PSM Servers."
    Write-Host "2: Press '2' for CPM service restart on all CPM Servers."
    Write-Host "3: Press '3' for Secure Tunnel service restart on all Secure Tunnel Servers."
    Write-Host "4: Press '4' for list of script configuration."
    Write-Host "Q: Press 'Q' to quit."
}

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    Write-Host 'You chose option #1 - PSM service restart on all PSM Servers.'
    # Cyber-Ark Privileged Session Manager
    Foreach ($PSMserver in $PSMServers)
    {
    Write-Host "Attempting Cyber-Ark Privileged Session Manager service restart for $PSMserver"
    get-service 'Cyber-Ark Privileged Session Manager' -ComputerName $PSMserver | select Status,DisplayName
    get-service 'Cyber-Ark Privileged Session Manager' -ComputerName $PSMserver | Restart-Service
    get-service 'Cyber-Ark Privileged Session Manager' -ComputerName $PSMserver | select Status,DisplayName
    Write-Host "Completed Cyber-Ark Privileged Session Manager service restart for $PSMserver" -ForegroundColor Green
    }
    ###########################################
    } '2' {
    Write-Host 'You chose option #2 - CPM service restart on all CPM Servers.'
    # CyberArk Password Manager
    Foreach ($CPMserver in $CPMServers)
    {
    Write-Host "Attempting CyberArk Password Manager service restart for $CPMserver"
    get-service 'CyberArk Password Manager' -ComputerName $CPMserver | select Status,DisplayName
    get-service 'CyberArk Password Manager' -ComputerName $CPMserver | Restart-Service
    get-service 'CyberArk Password Manager' -ComputerName $CPMserver | select Status,DisplayName
    Write-Host "Completed CyberArk Password Manager service restart for $CPMserver" -ForegroundColor Green
    }
    ###########################################

    } '3' {
    Write-Host 'You chose option #3 - Secure Tunnel service restart on all Secure Tunnel Servers.'
    # CyberArkPrivilegeCloudSecureTunnel
    Foreach ($TunnelServer in $SecureTunnelServers)
    {
    Write-Host "Attempting CyberArkPrivilegeCloudSecureTunnel service restart for $TunnelServer"
    get-service CyberArkPrivilegeCloudSecureTunnel -ComputerName $TunnelServer | select Status,DisplayName
    get-service CyberArkPrivilegeCloudSecureTunnel -ComputerName $TunnelServer | Restart-Service
    get-service CyberArkPrivilegeCloudSecureTunnel -ComputerName $TunnelServer | select Status,DisplayName
    Write-Host "Completed CyberArkPrivilegeCloudSecureTunnel service restart for $TunnelServer" -ForegroundColor Green
    }
    ###########################################
    } '4' {
    Write-Host 'You chose option #4 - list of script configuration.'
    Write-Host "Array of PSM Servers"
    Write-Host $PSMServers -ForegroundColor Green
    Write-Host "Array of CPM Servers"
    Write-Host $CPMServers -ForegroundColor Green
    Write-Host "Array of Secure Tunnel Servers"
    Write-Host $SecureTunnelServers -ForegroundColor Green
    Write-Host "If you want the servers changes, please update lines 2-4 of this script."
    }
    }
    pause
 }
 until ($selection -eq 'q')


