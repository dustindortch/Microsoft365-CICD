Describe 'Exchange Online' {
    Context 'OrganizationConfig' {
        $Expected = Get-Content "$PSScriptRoot\OrganizationConfig.jscon" | ConvertFrom-Json
        $Actual = Get-OrganizationConfig

        Context 'Modern Authentication' {
            It 'should be enabled' {
                $Property = 'OAuth2ClientProfileEnabled'
                $Actual.$($Property) | Should Be $Expected.$($Property)
            }
        }
    }

    #BeforeAll {
    #    Connect-ExoPSSession
    #}
}