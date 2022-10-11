
Describe 'policylinks' {
    BeforeAll {
        Import-Module .\modules\PolicyLinks.psm1
    }
    Context 'Get-PolicyLink' {    
        It 'Should return an object of plink' {
            InModuleScope PolicyLinks {
                $result = Get-PolicyLink -description "My New Policy for Users" -enableCompliant $true `
                    -id $null -linkType "Role" -policySet "/Policy/My New Policy" `
                    -params @("Privilege_Cloud_Admins_ID", "Privilege_Cloud_Auditors_ID") `
                    -i18NDescriptionTag $null -allowedpolicies @() -filters @()

                $result.GetType() | Should -Be hashtable
                $result.Description | Should -Be "My New Policy for Users"
                $result.Params.Count | Should -Be 2
        
                $result.ContainsKey("Params") | Should -Be $true
                $result.ContainsKey("I18NDescriptionTags") | Should -Be $false
                $result.ContainsKey("Allowedpolicies") | Should -Be $false
                $result.ContainsKey("Filters") | Should -Be $false
            }
        }
    }
    Context 'Get-PolicyBlock' {
        It 'Should return an object containing both plinks and policy' {
            $testData = Get-Content -Path .\tests\configs\policylinks.json | ConvertFrom-Json
            
            $result = Get-PolicyBlock -currentPolicyLinks $testData.plinks -newPolicyDescription "This is my new policy for users" `
                -newPolicyLinkType "Role" -newPolicyParams @("Privilege_Cloud_Admins_ID", "Privilege_Cloud_Auditors_ID") `
                -newPolicySet "/Policy/New Policy for Users" -newPolicyPriority 1 -newPolicyAllowedPolicies @() `
                -newPolicyFilters @() -policySettings $testData.policy
            $result.plinks.Count | Should -Be 4
        }
    }
}