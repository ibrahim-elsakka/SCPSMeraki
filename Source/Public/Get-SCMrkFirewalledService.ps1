function Get-SCMrkFirewalledService {
    <#
    .SYNOPSIS
        Cmdlet for retrieving a specified firewalled service from a network
    .DESCRIPTION
        This cmdlet will retrieve information on a specific firewalled service on a network.
        It will retrieve information such as Access policy, Allowed IPs.
    .EXAMPLE
        PS C:\> Get-SCMrkFirewalledService -Id $Id -Service "SNMP"
        
        This example will retrieve a PowerShell object containing configurations for the SNMP firewalled service
        on a specific network
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-firewall-firewalled-service
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$true)]
        [String]$Service
    )
    
    begin {
        Write-Verbose -Message "Querying Meraki API for firewalled service: $($Service) in Network: $($Id)"
    }
    
    process {
        try {
            Write-Verbose -Message "Retrieving Meraki Device"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/firewalledServices/$($Service)" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }
    
    end {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
