function Set-SCMrkAuth {
    <#
    .SYNOPSIS
        Cmdlet for connecting to Meraki Dashboard API.
    .DESCRIPTION
        Cmdlet whitch which will authenticate your API key with Meraki Dashboard
        The cmdlet is necessary for not having to provide the API Key for the
        follwing cmdlets you will use.
    .EXAMPLE
        PS C:\> Set-SCMrkAuth -ApiKey "<api_key>"
        
        This example will connect to the Meraki Dashboard API. If you have multiple Organisations
        attached to your API key, the cmdlet will atumatically connect you to the firs Organisation.
    .EXAMPLE
        PS C:\> Set-SCMrkAuth -ApiKey "<api_key>" -OrgId "<organisation_id>"

        This examplel will connect you to the Merakii Dashboard API, and to the specific organisation
        specified with the parameter OrgId
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .PARAMETER OrgId
        Organisation Id for the specific Organisation you want to connect to. If you only have a single
        organisation, you can skip this parameter. If you have multiple Organisations but don't provide
        an organisation id the cmdlet will automatically connect you to the first organisation it
        retrieves.
    .INPUTS
        System.String[] - You can pipe the ApiKey as a string into the cmdlet
    .OUTPUTS
        System.String[] - The cmdlet returns a string with successfull statement, if connection was successfull
    .NOTES
        n/a
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Please provide and API Key:", ValueFromPipeline=$true)]
        [ValidateLength(38,41)]
        [String]$ApiKey,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$OrgId
    )

    Begin {
        Write-Verbose -Message "Initiating Meraki Dashboard Authentication with ApiKey: $($ApiKey)"
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