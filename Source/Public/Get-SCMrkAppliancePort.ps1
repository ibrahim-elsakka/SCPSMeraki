function Get-SCMrkAppliancePort {
    <#
    .SYNOPSIS
        Cmdlet for retrieving data on a specific MX Appliance port in a Network
    .DESCRIPTION
        This cmdlet will retrieve an Object with configuration data on a specific MX
        appliance port
    .EXAMPLE
        PS C:\> Get-SCMrkAppliancePorts -Id $id -Port 1
        
        This example will retrieve data on port 1 on the MX appliance in the network: $id
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-port
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
        [String]$PortId
    )
    
    begin {
        Write-Verbose -Message "Querying Meraki API for the Appliance port: $($PortId) in Network: $($Id)"
    }
    
    process {
        try {
            Write-Verbose -Message "Retrieving Meraki Appliance Port: $($PortId) on network: $($Id)"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/ports/$($PortId)" -ApiKey $ApiKey
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