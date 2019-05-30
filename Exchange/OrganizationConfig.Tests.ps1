Describe 'Exchange Online' {
    Context 'OrganizationConfig' {
        $Expected = Get-Content "$PSScriptRoot\OrganizationConfig.json" | ConvertFrom-Json
        $Actual = Get-OrganizationConfig

        Context 'Modern Authentication' {
            It 'should be enabled' {
                $Property = 'OAuth2ClientProfileEnabled'
                $Actual.$($Property) | Should Be $Expected.$($Property)
            }
        }
        
        Content 'Auto Expanding Archives' {
            It 'should be enabled' {
                $Property = 'AutoExpandingArchiveEnabled'
                $Actual.$($Property) | Should Be $Expected.$($Property)
            }
        }
    }
}
