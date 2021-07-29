function Set-SCMrkNetworkSNMP {
    <#
    .SYNOPSIS
        Cmdlet for setting SNMP configurations on a specific Meraki Network.
    .DESCRIPTION
        Cmdlet for setting SNMP configurations on a specfic Meraki Network. This cmdlet can be used
        for setting either Version 1/2c or 3 on a Meraki Network. You will still need to configure 
        access in the L3 firewall besides setting this configuration.
    .EXAMPLE
        PS C:\> Set-SCMrkNetworkSNMP -Id L_918231134598135 -SetCommunity -CommunityString "Password1"
        
        This example will configure SNMP V1/2c for the network L_918231134598135. It will set the Community String:
        Password1
    
    .EXAMPLE
        PS C:\> Set-SCMrkNetworkSNMP -Id L_918231134598135 -SetUsers -UserPass "Password1" -UserName "User1"
        
        This example will configure SNMP V3 for the network L_918231134598135. It will set a user with Username: User1
        and Password: Password1. If there are already a user configured it will just add the user to the list.
    
    .EXAMPLE
        PS C:\> Set-SCMrkNetworkSNMP -Id L_918231134598135 -DisableSNMP

        This example will disable SNMP on the network. All SNMP configurations such as users for Version 3 will be erased.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-snmp
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$false, ParameterSetName="Community")]
        [Switch]$SetCommunity,
        [Parameter(Mandatory=$true, ParameterSetName="Community")]
        [String]$CommunityString,
        [Parameter(Mandatory=$false, ParameterSetName="V3")]
        [Switch]$SetUsers,
        [Parameter(Mandatory=$true, ParameterSetName="V3")]
        [String]$UserPass,
        [Parameter(Mandatory=$true, ParameterSetName="V3")]
        [String]$UserName,
        [Parameter(Mandatory=$false, ParameterSetName="Disable")]
        [Switch]$DisableSNMP

    )

    Begin {
        if($SetCommunity.IsPresent){
            Write-Verbose -Message "SNMP V1/V2c has been chosen"
        }
        elseif($SetUsers.IsPresent){
            Write-Verbose -Message "SNMP V3 has been chosen"
        }
        elseif($DisableSNMP.IsPresent){
            Write-Verbose -Message "Disabling SNP has been chosen"
            $Disable = $true
        }
        elseif($SetCommunity.IsPresent -and $SetUsers.IsPresent){
            Write-Error 'You may not set both -SetCommunity and -SetUsers Switch parameter. You may only specify one of them.'
            Exit
        }
        else {
            Write-Error -Message "You need to set either -SetCommunity switch or -SetUsers switch."
            Exit
        }
    }

    Process {
        if(!$Disable){
            if($SetCommunity.IsPresent){
                Write-Verbose -Message "Setting SNMP V1/V2c configurations for network: $($Id)"
                $payload = New-Object -TypeName PSObject -Property @{
                    "access" = "community"
                    "communityString" = "$($CommunityString)"
                }
            }
            elseif($SetUsers.IsPresent){
                Write-Verbose -Message "Setting SNMP V3 configurations for network: $($Id)"
                $NewUsersObject = New-Object -TypeName psobject -Property @{
                    "username" = "$($UserName)"
                    "passphrase" = "$($UserPass)"
                }

                try {
                    $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey
                    if($result.users){
                        $OldUsersObject = $result.users
                    }
                    else{
                        Write-Verbose -Message "No snmp user configurations was found"
                    }
                }
                catch {
                    Write-Error "$($_)"
                }

                if($OldUsersObject){
                    Write-Verbose -Message "OldUsersObject was found generating payload"
                    $UsersObject = New-PRSNMPUsersObject -OldUsersObject $OldUsersObject -NewUsersObject $NewUsersObject
                    $payload = New-Object -TypeName PSObject -Property @{
                        "users" = $UsersObject
                        "access" = "users"
                    }
                }
                else {
                    Write-Verbose -Message "No oldUsersObject was found, generating new"
                    $ArrayObject = New-Object System.Collections.ArrayList
                    $ArrayObject.Add($NewUsersObject)
                    $payload = New-Object -TypeName PSObject -Property @{
                        "users" = $ArrayObject
                        "access" = "users"
                    }
                }
            }
        }
        else {
            Write-Warning -Message "Disabling SNMP for network: $($Id)"
            $payload = New-Object -TypeName PSObject -Property @{
                "access" = "none"
            }
        }

        if($payload){
            Write-Verbose -Message "payload has been created sending HTTP request to the API"
            Write-Output -InputObject ($payload | ConvertTo-Json)
            
            try {
                $result = Invoke-PRMerakiApiCall -Method PUT -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey -Payload $payload
            }
            catch {
                Write-Error "$($_)"
            }
        }
    }

    End {
        $users = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey
        if($users.users.username -contains $UserName){
            Write-Verbose -Message "User was successfully added to snmp configurations"
        }
    }
}
