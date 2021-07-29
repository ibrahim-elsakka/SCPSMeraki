function Set-SCMrkNetworkSNMP {
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
