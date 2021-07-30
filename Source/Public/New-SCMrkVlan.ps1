function New-SCMrkVlan {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$true, HelpMessage="The Ipaddress of the MX Appliance")]
        [String]$DefaultGateway,
        [Parameter(Mandatory=$false)]
        [String]$GroupPolicyId,
        [Parameter(Mandatory=$true, HelpMessage="The number ID of the VLAN")]
        [String]$VlanId,
        [Parameter(Mandatory=$true, HelpMessage="The name of the VLAN")]
        [String]$Name,
        [Parameter(Mandatory=$true, HelpMessage="The subnet of the VLAN")]
        [String]$Subnet
    )

    Begin {
        Write-Verbose -Message "The VLAN: $($Name), with ID: $($VlanId) will be created"
        Write-Verbose -Message "Creating with subnet: $($Subnet), and Default Gateway: $($DefaultGateway)"
    }

    Process {
        $payload = New-Object -TypeName psobject -Property @{
            "id"                = $VlanId
            "name"              = $Name
            "subnet"            = $Subnet
            "applianceIp"       = $DefaultGateway
            "groupPolicyId"     = $GroupPolicyId
        }
        if(!$GroupPolicyId){
            $payload = $payload | Select-Object -ExcludeProperty groupPolicyId
        }

        try {
            $result = Invoke-PRMerakiApiCall -Method POST -Resource "/networks/$($Id)/appliance/vlans" -ApiKey $ApiKey -Payload $payload
        }
        catch {
            Write-Error -Message "$($_)"
        }
    }

    End {
        if($result){
            try {
                $request =  Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/vlans/$($VlanId)" -ApiKey $ApiKey
                return $request
            }
            catch {
                Write-Error -Message "$($_)"
            }
        }
    }
}