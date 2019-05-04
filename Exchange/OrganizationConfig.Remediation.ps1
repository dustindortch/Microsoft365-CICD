[CmdletBinding()]
Param (
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $FailedCount,

    [Parameter(ValueFromPipelineByPropertyName)]
    $TestResult
)

$Expected = Get-Content "$PSScriptRoot\OrganizationConfig.json" | ConvertFrom-Json

Write-Verbose '****Initiating remediation****'

If ($FailedCount -ne 0) {
    $OrganizationConfig = @{ }

    Switch ($TestResult.Context) {
        'OrganizationConfig\Modern Authentication' {
            Write-Verbose '    *Remediating Modern Authentication'
            $Property = 'OAuth2ClientProfileEnabled'
            $OrganizationConfig.Add($Property, $Expected.$($Property))
        }
    }

    Set-OrganizationConfig @OrganizationConfig
} Else {
    Write-Verbose '    *No remediation required*'
}