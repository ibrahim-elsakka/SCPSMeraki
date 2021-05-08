### --- PUBLIC FUNCTIONS --- ###
#Region - Get-SCMrkNetworks.ps1
function Get-SCMrkNetworks {

    param (
        [String]$OrgId = $OrgId,
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrievel of Meraki Networks in Organisation: $($OrgId)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Networks"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/organizations/$($OrgId)/networks" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkNetworks
#EndRegion - Get-SCMrkNetworks.ps1
#Region - Set-SCMrkAuth.ps1
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
Export-ModuleMember -Function Set-SCMrkAuth
#EndRegion - Set-SCMrkAuth.ps1
### --- PRIVATE FUNCTIONS --- ###
#Region - Invoke-PRMerakiApiCall.ps1
function Invoke-PRMerakiApiCall {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("POST", "GET", "PUT", "DELETE")]
        [String]$Method,
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [String]$Resource,
        [Parameter(Mandatory=$true)]
        [String]$ApiKey    
    )

    begin {
        Write-Verbose -Message "Setting the API Key $($ApiKey) as a Script Varaible"
        New-Variable -Name ApiKey -Value $ApiKey -Scope Script -Force
        
        $baseUrl = "https://api.meraki.com/api/v1/"
        Write-Verbose -Message "Setting the base url: "

        $headers = @{
            "Content-Type" = "application/json"
            "Accept" = "application/json"
            "X-Cisco-Meraki-API-Key" = $ApiKey
        }
        Write-Verbose -Message "Setting the API Call headers"
    }

    process {
        Write-Verbose -Message "Invoking the API call with uri: $($baseUrl)/$($Resource) and the Method: $($Method)"
        try {
            $result = Invoke-RestMethod -Uri $baseUrl/$Resource -Method $Method -Headers $headers
            return $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    end {
        if(!($result)){
            Write-Error -Message " HTTP Status Code: $($statusCode) - Error Description: $statusDescription"
        }
    }
}
#EndRegion - Invoke-PRMerakiApiCall.ps1
