function Set-SCMrkSwitchPort {
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
        # Default Cmdlet Parameters
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,

        # Default Switch Port Parameters
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Serial,
        [Parameter(Mandatory=$true)]
        [String]$PortId,
        [Parameter(Mandatory=$true, HelpMessage="Enter descriptive name of the port")]
        [String]$Name,
        [Parameter(Mandatory=$false)]
        [Boolean]$Enabled = $true,
        [Parameter(Mandatory=$false)]
        [Boolean]$poeEnabled = $true,
        [Parameter(Mandatory=$true, HelpMessage="Enter a VLAN Id")]
        [String]$Vlan,
        [Parameter(Mandatory=$false)]
        [String]$VoiceVlan,
        [Parameter(Mandatory=$false)]
        [Boolean]$isolationEnabled = $false,
        [Parameter(Mandatory=$false)]
        [Boolean]$rstpEnabled = $true,
        [Parameter(Mandatory=$false)]
        [String]$stpGuard = "disabled",
        [Parameter(Mandatory=$false)]
        [String]$LinkNegotiation = "Auto negotiate",
        [Parameter(Mandatory=$false)]
        [String]$udld = "Alert only",

        # Default Access Port Parameters
        [Parameter(Mandatory=$false, ParameterSetName="access")]
        [Switch]$AccessPort,
        [Parameter(Mandatory=$false, ParameterSetName="access")]
        [String]$AccessPolicy = "Open",

        # Default Trunk Port Parameters
        [Parameter(Mandatory=$false, ParameterSetName="trunk")]
        [Switch]$TrunkPort,
        [Parameter(Mandatory=$false, ParameterSetName="trunk")]
        [String]$AllowedVlans
    )

    Begin {
        if($AccessPort.IsPresent){
            Write-Verbose -Message "Configuring Port: $($PortId) as an Access Port"
        }
        elseif($TrunkPort.IsPresent){
            Write-Verbose -Message "Configuring Port $($PortId) as a Trunk Port"
        }
        else {
            Write-Error -Message "Neither of -AccessPort or -TrunkPort Switches where set as a parameter. Exiting function."
            Exit
        }
    }

    Process {

        if($AccessPort.IsPresent){
            Write-Verbose -Message "Creating Access Port Data Object"
            $payload = New-Object -TypeName PSObject -Property @{
                "portId"                = $PortId
                "name"                  = $Name
                "enabled"               = $Enabled
                "poeEnabled"            = $poeEnabled
                "type"                  = "access"
                "vlan"                  = $Vlan
                "voiceVlan"             = $VoiceVlan
                "allowedVlans"          = ""
                "isolationEnabled"      = $IsolationEnabled
                "rstpEnabled"           = $rstpEnabled
                "stpGuard"              = $stpGuard
                "linkNegotiation"       = $LinkNegotiation
                "udld"                  = $udld
                "accessPolicyType"      = $AccessPolicy
            }
            if(!$VoiceVlan){
                $payload = $payload | Select-Object -ExcludeProperty voiceVlan
            }
        }
        elseif($TrunkPort.IsPresent){
            Write-Verbose -Message "Creating Trunk Port Data Object"
            $payload = New-Object -TypeName PSObject -Property @{
                "portId"                = $PortId
                "name"                  = $Name
                "enabled"               = $Enabled
                "poeEnabled"            = $poeEnabled
                "type"                  = "trunk"
                "vlan"                  = $Vlan
                "allowedVlans"          = $AllowedVlans
                "isolationEnabled"      = $IsolationEnabled
                "rstpEnabled"           = $rstpEnabled
                "stpGuard"              = $stpGuard
                "linkNegotiation"       = $LinkNegotiation
                "udld"                  = $udld
            }
        }
        
        try {
            $result = Invoke-PRMerakiApiCall -Method PUT -Resource "/devices/$($Serial)/switch/ports/$($PortId)" -ApiKey $ApiKey -Payload $payload
        }
        catch {
            Write-Error -Message "$($_)"
        }
        

    }

    End {
        if($result){
            try {
                $request =  Invoke-PRMerakiApiCall -Method GET -Resource "/devices/$($Serial)/switch/ports/$($PortId)" -ApiKey $ApiKey
                return $request
            }
            catch {
                Write-Error -Message "$($_)"
            }
        }
    }
}