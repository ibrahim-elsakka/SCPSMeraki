function Set-SCMrkAuth {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Please provide and API Key:")]
        [String]$ApiKey,
        [Parameter(Mandatory=$false)]
        [String]$OrgId
    )

    Begin {
        Write-Verbose -Message "Initiating Meraki Dashboard Authentication"
    }

    Process {
        if(!($OrgId)){
            Write-Verbose -Message "Authenticating to Meraki Dashboard API"
            try {
                $OrgId = Invoke-PRMerakiApiCall -Method GET -Resource "/organizations" -ApiKey $ApiKey | Select-Object -ExpandProperty Id -First 1
                Write-Verbose -Message "Setting the OrgId: $($OrgId) Variable as Script Scope"
                New-Variable -Name OrgId -Value $OrgId.ToString() -Scope Script -Force
                Write-Output -InputObject "Successfully conncted to Meraki API!"
            }
            catch {
                $statusCode = $_.Exception.Response.StatusCode.value__
                $statusDescription = $_.Exception.Response.StatusDescription
            }
        }
        elseif($OrgId){
            Write-Verbose -Message "Validating Organisation Id provided in parameter agains Meraki Dashboard API"
            try {
                $OrgIds = Invoke-PRMerakiApiCall -Method GET -Resource "/organizations" -ApiKey $ApiKey | Select-Object -ExpandProperty Id
                if($OrgIds -contains $OrgId){
                    Write-Verbose -Message "Setting the OrgId: $($Orgid) Variable as Script Scope"
                    New-Variable -Name OrgId -Value $OrgId.ToString() -Scope Script -Force
                    Write-Output -InputObject "Successfully conncted to Meraki API!"
                }
                else {
                    $statusCode = $_.Exception.Response.StatusCode.value__
                    $statusDescription = "Organisation Id provided in Parameter, was not found in your Meraki Dashboard"
                }
            }
            catch {
                $statusCode = $_.Exception.Response.StatusCode.value__
                $statusDescription = $_.Exception.Response.StatusDescription
            }
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}