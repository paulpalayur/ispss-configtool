function Get-PolicyBlock {
    [CmdletBinding()]
    param (
        $currentPolicyLinks,
        $newPolicyDescription,
        $newPolicyLinkType,
        $newPolicyParams,
        $newPolicySet,
        $newPolicyPriority,
        $newPolicyAllowedPolicies,
        $newPolicyFilters,        
        $policySettings
    )
    $plinks = [System.Collections.ArrayList]@()

    $policyLink = @{}
    $policyLink = Get-PolicyLink -description $newPolicyDescription -enableCompliant $null -id $null `
        -linkType $newPolicyLinkType -policySet $newPolicySet -params $newPolicyParams -i18NDescriptionTag $null `
        -allowedpolicies $newPolicyAllowedPolicies -filters $newPolicyFilters

    $plinks.Add($policyLink) | Out-Null

    foreach ($plink in $currentPolicyLinks) {
        $policyLink = @{}
        $description = $plink.Row.Description
        $enableCompliant = $plink.Row.EnableCompliant
        $id = $plink.Row.ID
        $linkType = $plink.Row.LinkType
        $policySet = $plink.Row.PolicySet
        $params = @()
        if ("Params" -in $plink.Row.PSObject.Properties.Name) {
            $params = $plink.Row.Params
        }
        $i18NDescriptionTag = ""
        if ("I18NDescriptionTag" -in $plink.Row.PSObject.Properties.Name) {
            $i18NDescriptionTag = $plink.Row.I18NDescriptionTag
        }
        $allowedpolicies = @()
        if ("Allowedpolicies" -in $plink.Row.PSObject.Properties.Name) {
            $allowedpolicies = $plink.Row.Allowedpolicies
        }
        $filters = @()
        if ("Filters" -in $plink.Row.PSObject.Properties.Name) {
            $filters = $plink.Row.Filters
        }

        $policyLink = Get-PolicyLink -description $description -enableCompliant $enableCompliant -id $id `
            -linkType $linkType -policySet $policySet -params $params -i18NDescriptionTag $i18NDescriptionTag `
            -allowedpolicies $allowedpolicies -filters $filters

        $plinks.Add($policyLink) | Out-Null
    }
    if ($plinks.Count -gt 1) {
        [array]::Reverse($plinks)
    }    
    $policyBlock = [ordered]@{ "plinks" = $plinks ; "policy" = $policySettings }    
    return $policyBlock
}

function Get-PolicyLink {
    [CmdletBinding()]
    param (
        $description,
        $enableCompliant,
        $id,
        $linkType,
        $policySet,
        $params,
        $i18NDescriptionTag,
        $allowedpolicies,
        $filters
    )
    $policyLink = @{}
    $policyLink.Description = $description
    if ($enableCompliant) {
        $policyLink.EnableCompliant = $enableCompliant
    }
    if ($id) {
        $policyLink.ID = $id
    }
    
    $policyLink.LinkType = $linkType
    $policyLink.PolicySet = $policySet
    if ($params) {
        $policyLink.Params = $params
    }
    if ($i18NDescriptionTag) {
        $policyLink.I18NDescriptionTag = $i18NDescriptionTag
    }
    if ($allowedpolicies) {
        $policyLink.Allowedpolicies = $allowedpolicies
    }
    if ($filters) {
        $policyLink.Filters = $filters
    }
    return $policyLink
}
Export-ModuleMember -Function Get-PolicyBlock