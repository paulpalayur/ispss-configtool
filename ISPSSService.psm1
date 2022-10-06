$subdomainApiUrl = $null
$headers = @{}

function Get-Token {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$subdomain, 

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$APICredentials,

        [Parameter(Mandatory = $false)]
        [string]$grant_type = "client_credentials"
    )
    
    begin {
        $username = $APICredentials.UserName
        $password = $APICredentials.GetNetworkCredential().Password
        $body=@{
            client_id = $username
            client_secret = $password
            grant_type = $grant_type
        }
        $token_endpoint = "https://$($subdomain).cyberark.cloud/api/idadmin/oauth2/platformtoken"
    }
    
    process {
        try {
            $response = Invoke-RestMethod -Uri $token_endpoint -Method Post -Body $body
            $global:subdomainApiUrl = "https://$($subdomain).cyberark.cloud/api/idadmin"
            $global:headers = @{"Authorization" = "Bearer $($response.access_token)"}
            return $true
        }
        catch {
            if($_.ErrorDetails.Message) {
                Write-Error $_.ErrorDetails.Message
            } else {
                Write-Error $_
            }
        }
    }
}

function Get-AuthProfiles {
    [CmdletBinding()]
    param (

    )
    
    begin {                
        $reqUrl = "$($global:subdomainApiUrl)/AuthProfile/GetProfileList"
    }
    
    process {
        $response = Invoke-RestMethod -Uri $reqUrl -Method Get -Headers $global:headers
        return $response
    }
}

function Get-AuthProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProfileUuid
    )
    
    begin {
        $reqUrl = "$($global:subdomainApiUrl)/AuthProfile/GetProfile?uuid=${ProfileUuid}"
    }
    
    process {
        $response = Invoke-RestMethod -Uri $reqUrl -Method Get -Headers $global:headers
        return $response
    }
}

function Get-PolicyLinks {
    [CmdletBinding()]
    param (
  
    )
    
    begin {
        $reqUrl = "$($global:subdomainApiUrl)/Policy/GetNicePlinks"
    }
    
    process {
        $response = Invoke-RestMethod -Uri $reqUrl -Method Get -Headers $global:headers
        return $response
    }
}

function Set-AuthProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$profileName = "MFA for Users",

        [Parameter(Mandatory = $false)]
        [string]$body = '{
            "settings": {
               "Challenges": [
                  "UP",
                  "OTP,OATH,QR,U2F"
               ],
               "DurationInMinutes": 30,
               "Name": "'+ $profileName +'" 
            }
         }'
    )
    
    begin {
        $reqUrl = "$($global:subdomainApiUrl)/AuthProfile/SaveProfile"
    }
    
    process {        
        $response = Invoke-RestMethod -Uri $reqUrl -Method Post -Headers $global:headers -ContentType 'application/json' -Body $body
        return $response
    }
}

function Set-PolicyBlock {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PolicyBlock 
    )
    
    begin {
        $reqUrl = "$($global:subdomainApiUrl)/policy/savepolicyblock3"
    }
    
    process {        
        $response = Invoke-RestMethod -Uri $reqUrl -Method Post -Headers $global:headers -ContentType 'application/json' -Body $body
    }
    
    end {
        
    }
}
Export-ModuleMember -Function *
