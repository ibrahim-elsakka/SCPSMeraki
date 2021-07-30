function Get-SCMrkAppliancePorts {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all appliance ports from a specified network
    .DESCRIPTION
        This cmdlet will retrieve an object containing configuration data on all the ports
        on a MX appliance.
    .EXAMPLE
        PS C:\> Get-SCMrkAppliancePorts -Id $id
        
        This example will retrieve information on all the ports on the MX appliance on the network $Id
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-ports
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )
    
    begin {
        Write-Verbose -Message "Querying Meraki API for Appliance ports in Network: $($Id)"
    }
    
    process {
        try {
            Write-Verbose -Message "Retrieving Meraki Appliance Ports from network: $($Id)"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/ports" -ApiKey $ApiKey
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