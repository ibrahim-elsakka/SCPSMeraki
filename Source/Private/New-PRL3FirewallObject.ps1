function New-PRL3FirewallObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [Object]$OldRulesObject,
        [Parameter(Mandatory=$true)]
        [Object]$NewRulesObject,
        [Parameter(Mandatory=$false)]
        [Boolean]$PlaceOnTop
    )

    Begin {
        Write-Verbose -Message "Creating a new Rules object to set the firewall rules from"
    }

    Process {
        if($PlaceOnTop -eq $true){
            Write-Verbose -Message "Generating the new Rules object with the new rule in the top"
            $RulesObject = New-Object System.Collections.ArrayList
            $null = $RulesObject.Add($NewRulesObject)

            foreach($rule in $OldRulesObject){
                $object = New-Object -TypeName PSObject -Property @{
                    "comment"       = "$($rule.comment)"
                    "policy"        = "$($rule.policy)"
                    "protocol"      = "$($rule.protocol)"
                    "srcPort"       = "$($rule.srcPort)"
                    "srcCidr"       = "$($rule.srcCidr)"
                    "destPort"      = "$($rule.destPort)"
                    "destCidr"      = "$($rule.srcCidr)"
                    "syslogEnabled" = "$($rule.syslogEnabled)"
                }

                $null = $RulesObject.Add($object)
            }

            return $RulesObject
        }
        elseif($PlaceOnTop -eq $false) {
            Write-Verbose -Message "Generating the new Rules object with the new rule in the bottom"
            $RulesObject = New-Object System.Collections.ArrayList
                foreach($rule in $OldRulesObject){
                    $object = New-Object -TypeName PSObject -Property @{
                        "comment"       = "$($rule.comment)"
                        "policy"        = "$($rule.policy)"
                        "protocol"      = "$($rule.protocol)"
                        "srcPort"       = "$($rule.srcPort)"
                        "srcCidr"       = "$($rule.srcCidr)"
                        "destPort"      = "$($rule.destPort)"
                        "destCidr"      = "$($rule.srcCidr)"
                        "syslogEnabled" = "$($rule.syslogEnabled)"
                    }
                    $null = $RulesObject.Add($object)
                }

                $null = $RulesObject.Add($NewRulesObject)
                return $RulesObject
            }
        }

    End {
        if($RulesObject){
            Write-Verbose -Message "Sucussfully created a Rules Object"
            foreach($rule in $RulesObject){
                Write-Verbose -Message "Rule comment: $($rule.comment)"
                Write-Verbose -Message "Rule policy: $($rule.policy)"
                Write-Verbose -Message "-----------------------------"
            }
        }
        else {
            Write-Verbose -Message "Couldn't find any rules object created."
        }
    }
}