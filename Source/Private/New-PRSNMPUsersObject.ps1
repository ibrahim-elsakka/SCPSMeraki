function New-PRSNMPUsersObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [Array]$OldUsersObject,
        [Parameter(Mandatory=$true)]
        [Object]$NewUsersObject
    )

    Write-Verbose -Message "Compiling the two users object into a single array object"
    $UsersObject = New-Object System.Collections.ArrayList
    Write-Verbose -Message "Generating the new object"
    foreach($user in $OldUsersObject){
        $object = New-Object -TypeName psobject -Property @{
            "username" = "$($user.username)"
            "passphrase" = "$($user.passphrase)"
        }
        $null = $UsersObject.Add($object)
    }
    
    try {
        Write-Verbose "Adding the new users to the old users array"
        $null = $UsersObject.Add($NewUsersObject)
        foreach($user in $UsersObject){
            Write-Verbose -Message "User: $($user.username)"
            Write-Verbose -Message "Passphrase: $($user.passphrase)"
        }
        return $UsersObject
    }
    catch {
        Write-Error -Message $($_)
    }
}