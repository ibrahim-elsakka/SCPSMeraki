function Get-SCMrkNetworks {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all networks in an Meraki Organisation.
    .DESCRIPTION
        This cmdlet will retrieve a powershell object with information on all
        the networks in your Meraki Organisation.
    .EXAMPLE
        PS C:\> Get-SCMrkNetworks -OrgId "<organisation_id>" -ApiKey "<api_key>"

        This example will take an ApiKey and an Organisation Id and retrieve all networks
        in that organisation.
    .EXAMPLE
        PS C:\> Get-SCMrkNetworks

        If you have already run Set-SCMrkAuth, then you will not need to provide any
        other parameters for retriving networks in that organisation you specified in
        Set-MrkAuth.
    .PARAMETER OrgId
        Organisation id of the specific organisation you want to see the devices from.
        If you have run Set-SCMrkAuth before running this cmdlet the parameter is not necessary.
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe OrgId as a string into the cmdlet.
    .OUTPUTS
        System.Array[] - The cmdlet will output an PS Object with an array of all the networks.
    .NOTES
        n/a
    #>

    [CmdletBinding()]
    [Alias('scgn')]
    param (
        [Parameter(Mandatory=$false, valueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$OrgId = $OrgId,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
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