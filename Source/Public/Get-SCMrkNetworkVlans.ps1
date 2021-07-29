function Get-SCMrkNetworkVlans {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all Network Vlans and Subnets.
    .DESCRIPTION
        Cmdlet which will retrieve an array of object containing each subnet or vlan configured on a
        Meraki network.
    .EXAMPLE
        PS C:\> Get-SCMrkNetworkVlans -Id L_918231134598135
        
        This example will return an array of all the vlans configured on the network with
        Id L_918231134598135.
    .EXAMPLE
        PS C:\> (Get-SCMrkNetworks | ? name -eq "TEST-NETWORK").Id | Get-SCMrkNetworkVlans

        This example will pass the id of the network: TEST-NETWORK into the cmdlet Get-SCMrkNetworkVlans
        and retrieve all the vlans for that specific network.
    .INPUTS
        System.String[] - You can pipe the Id(network id) into the cmdlet
    .OUTPUTS
        System.Array[] - The cmdlet will output an PSObject with an array of all the vlans
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-vlans
    .Link
        Online Help: https://scriptingchris.tech
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

    Begin {
        Write-Verbose -Message "Initiating retrieval of all vlans associated to the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Network Vlans"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/vlans" -ApiKey $ApiKey
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
