function Get-SCMrkNetworkSNMP {
    <#
    .SYNOPSIS
        Cmdlet for retrieving SNMP configurations of a network
    .DESCRIPTION
        This cmdlet will query a specific network and output the SNMP configurations from it
    .EXAMPLE
        PS C:\> Get-SCMrkNetworkSNMP -Id L_918231134598135
        
        This example will retrieve the SNMP configurations from the network L_918231134598135
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-snmp
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
        Write-Verbose -Message "Initiating retrieval of snmp configurations for the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Network snmp config"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey
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