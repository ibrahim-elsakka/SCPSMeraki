function Set-SCMrkL3FirewallRule {
    <#
    .SYNOPSIS
        Cmdlet for adding a new L3 firewall rule to a network
    .DESCRIPTION
        This cmdlet will query all the existing L3 firewall rules and add a new rule to the list.
        You can chose to place the rule either on top or in the bottom of the list.
    .EXAMPLE
        PS C:\> $SplatArgs = @{
            Comment = "TEST - Allow snmp"
            Policy = "allow"
            Protocol = "udp"
            SourcePort = "161"
            SourceAddress = "any"
            DestinationPort = "161"
            DestinationAddress = "192.168.137.1"
            PlaceOnTop = $true
        }
        Set-SCMrkL3FirewallRule -Id $id @SplatArgs -Verbose

        This example will create a new firewall named "TEST - Allow snmp" In this example the rule is beeing
        passed to the cmdlet with splatting. You can also run the cmdlet in the conventional way.
        In this specific example the new rule will be placed in the top of all the rules. To specify that the 
        rule should be placed in the bottom you can define -PlaceOnTop as $false or not define it at all.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-firewall-l-3-firewall-rules
    .LINK
        Online Help: https://scriptingchris.tech
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
        [String]$Comment,
        [Parameter(Mandatory=$true)]
        [ValidateSet("allow", "deny")]
        [String]$Policy,
        [Parameter(Mandatory=$true)]
        [ValidateSet("any","tcp","udp","icmp")]
        [String]$Protocol,
        [Parameter(Mandatory=$true)]
        [String]$SourcePort,
        [Parameter(Mandatory=$true)]
        [String]$SourceAddress,
        [Parameter(Mandatory=$true)]
        [String]$DestinationPort,
        [Parameter(Mandatory=$true)]
        [String]$DestinationAddress,
        [Parameter(Mandatory=$false)]
        [String]$SyslogEnabled = "false",
        [Parameter(Mandatory=$false)]
        [Boolean]$PlaceOnTop = $false
    )

    Begin {
        Write-Verbose -Message "Creating new PS Object containing the new rule"
        $NewRulesObject = New-Object -TypeName PSObject -property @{
            "comment"       = "$($Comment)"
            "policy"        = "$($Policy)"
            "protocol"      = "$($Protocol)"
            "srcPort"       = "$($SourcePort)"
            "srcCidr"       = "$($SourceAddress)"
            "destPort"      = "$($DestinationPort)"
            "destCidr"      = "$($DestinationAddress)"
            "syslogEnabled" = "$($SyslogEnabled)"
        }

        if($NewRulesObject) {
            Write-Verbose -Message "Describing New Rules Object:"
            Write-Verbose -Message "Generating object comment: $($NewRulesObject.comment)"
            Write-Verbose -Message "Generating object policy: $($NewRulesObject.policy)"
            Write-Verbose -Message "Generating object protocol: $($NewRulesObject.protocol)"
            Write-Verbose -Message "Generating object srcPort: $($NewRulesObject.srcPort)"
            Write-Verbose -Message "Generating object srcCidr: $($NewRulesObject.srcCidr)"
            Write-Verbose -Message "Generating object destPort: $($NewRulesObject.destPort)"
            Write-Verbose -Message "Generating object destCidr: $($NewRulesObject.destCidr)"
            Write-Verbose -Message "Generating object syslogEnabled: $($NewRulesObject.syslogEnabled)"
        }
    }

    Process {
        Write-Verbose -Message "Querying dashboard for old L3 Firewall Rules Object"
        $OldRulesObject = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey
        if($OldRulesObject){
            foreach($rule in $OldRulesObject.rules){
                Write-Verbose -Message "Successfully queried the API for current firewall rules"
                Write-Verbose -Message "Rule comment: $($rule.comment)"
                Write-Verbose -Message "Rule policy: $($rule.policy)"
                Write-Verbose -Message "-----------------------------"
            }
            $rArray = New-Object -TypeName System.Collections.ArrayList
            foreach($rule in $OldRulesObject.rules){
                if(!($rule.comment -eq "Default rule")){
                    $null = $rArray.Add($rule)
                }
            }
            $OldRulesObject = New-Object -TypeName psobject -Property @{
                "rules" = $rArray
            }
        }

        Write-Verbose -Message "Passing old rules and new rules to process the new complete firewall rule list"
        try {
            $L3FirewallRules = New-PRL3FirewallObject -OldRulesObject $OldRulesObject.rules -NewRulesObject $NewRulesObject -PlaceOnTop $PlaceOnTop
        }
        catch {
            Write-Error -Message "$($_)"
        }

        if($L3FirewallRules){
            Write-Verbose "Found L3 Firewall Rules Object. Initiating PUT request to Meraki API"
            $Payload = [PSCustomObject]@{
                "rules" = $L3FirewallRules
            }
            
            try {
                Write-Verbose "Sending new rules to Meraki API for network $($Id)"
                Invoke-PRMerakiApiCall -Method PUT -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey -Payload $Payload
            }
            catch {
                Write-Error "$($_)"
            }
        }
    }

    End {
        $FinishedRulesList = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey
        if($FinishedRulesList.comment -contains $Comment) {
            Write-Verbose -Message "The new rule was successfully applied."
        }
        else {
            Write-Warning "Couldn't find the newly created firewall rule."
        }
    }
}