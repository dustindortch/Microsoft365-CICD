# Microsoft365-CICD
Infrastructure Validation/Configuration for Microsoft 365

## Summary
Managing Microsoft 365 via CI/CD pipeline with GitHub and Azure DevOps

## Process
Each workload has its own directory with Configurations, Tests, and Remediations.

* Exchange
* SharePoint (TBD)
* Skype for Business (TBD)
* Teams (TBD)

## Build configuration
For a given Get cmdlet, say its output to a JSON file named for the Noun to build a baseline:

```powershell
$Results = Get-OrganizationConfig
$Results | Select-Object OAuth2ClientProfileEnabled | ConvertTo-Json | Out-File .\Exchange\OrganizationConfig.json
```

## Write tests to validation tests

In the Exchange workload, I have started with an OrganizationConfig.Tests.ps1

This can be executed easily:

```powershell
Invoke-Pester
```
It should pass since we just built the configuration file from the actual value.  Change the value from true to false and save the configuration.  Then re-run the test; it should fail.

## Write the remediation for the test

The remediation accepts Invoke-Pester from the pipeline and specifically expects $FailedCount and $TestResult.  ```Invoke-Pester``` passes these when executed with the ```-PassThru``` parameter.

```powershell
Invoke-Pester -PassThru | .\Exchange\OrganizationConfig.Remediation.ps1
```

This will test, fail, and remediate to match the configuration file.

Now running the test should pass again:

```powershell
Invoke-Pester
```

## Implementing Azure DevOps

Now the repository should be monitored by Azure DevOps.  Any commits to master should re-execute the pipeline.  Commits are tracked, including the contributor, the date, and a full record of previous values.