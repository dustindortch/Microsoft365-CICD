[CmdletBinding()]
Param (
    [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'CI')]
    [Switch]$All,

    [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'CD')]
    [int]
    $FailedCount,

    [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'CD')]
    $TestResult
)

$Expected = Get-Content "$PSScriptRoot\OrganizationConfig.json" | ConvertFrom-Json

Write-Verbose '****Initiating remediation****'

If ($FailedCount -ne 0 -or $All) {
    $OrganizationConfig = @{ }

    Switch ($TestResult.Context) {
        ( {
            $PSItem -eq 'OrganizationConfig\Modern Authentication' -or
            $Null -eq $PSItem
        }) {
            Write-Verbose '    *Remediating Modern Authentication'
            $Property = 'OAuth2ClientProfileEnabled'
            $OrganizationConfig.Add($Property, $Expected.$($Property))
        }
    }

    Set-OrganizationConfig @OrganizationConfig
} Else {
    Write-Verbose '    *No remediation required*'
}