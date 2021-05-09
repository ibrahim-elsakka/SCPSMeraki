function Get-SCMrkDevices {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all (meraki)devices on a network
    .DESCRIPTION
        Cmdlet which will retrieve a PS Object with an array of all the networks claimed and added
        to a specific network
    .EXAMPLE
        PS C:\> Get-SCMrkDevices -Id "<network_id>"

        This example will retrive all the networks located on the network with the "<network_id>" you
        provided the in the parameter Id.
    .EXAMPLE
        PS C:\> (Get-SCMrkNetworks | ? Name -eq "Network1").Id | Get-SCMrkDevices

        This example will grap the id of the network with name "Network1" through the pipeline and
        return all the (network)devices on that specific network.
    .PARAMETER Id
        Network Id from the network you want to retrive the devices from.
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe the Id(network id) into the cmdlet  
    .OUTPUTS
        System.Array[] - The cmdlet will output an PS Object with an array of all the devices on the network.
    .NOTES
        n/a
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
        Write-Verbose -Message "Initiating retrieval of all devices associated to the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Networks"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/devices" -ApiKey $ApiKey
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