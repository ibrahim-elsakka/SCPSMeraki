---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkNetworkSNMP

## SYNOPSIS
Cmdlet for setting SNMP configurations on a specific Meraki Network.

## SYNTAX

### Community
```
Set-SCMrkNetworkSNMP -Id <String> [-ApiKey <String>] [-SetCommunity] -CommunityString <String>
 [<CommonParameters>]
```

### V3
```
Set-SCMrkNetworkSNMP -Id <String> [-ApiKey <String>] [-SetUsers] -UserPass <String> -UserName <String>
 [<CommonParameters>]
```

### Disable
```
Set-SCMrkNetworkSNMP -Id <String> [-ApiKey <String>] [-DisableSNMP] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet for setting SNMP configurations on a specfic Meraki Network.
This cmdlet can be used
for setting either Version 1/2c or 3 on a Meraki Network.
You will still need to configure 
access in the L3 firewall besides setting this configuration.

## EXAMPLES

### EXAMPLE 1
```
Set-SCMrkNetworkSNMP -Id L_918231134598135 -SetCommunity -CommunityString "Password1"
```

This example will configure SNMP V1/2c for the network L_918231134598135.
It will set the Community String:
Password1

### EXAMPLE 2
```
Set-SCMrkNetworkSNMP -Id L_918231134598135 -SetUsers -UserPass "Password1" -UserName "User1"
```

This example will configure SNMP V3 for the network L_918231134598135.
It will set a user with Username: User1
and Password: Password1.
If there are already a user configured it will just add the user to the list.

### EXAMPLE 3
```
Set-SCMrkNetworkSNMP -Id L_918231134598135 -DisableSNMP
```

This example will disable SNMP on the network.
All SNMP configurations such as users for Version 3 will be erased.

## PARAMETERS

### -Id
{{ Fill Id Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ApiKey
{{ Fill ApiKey Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $ApiKey
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetCommunity
{{ Fill SetCommunity Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Community
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommunityString
{{ Fill CommunityString Description }}

```yaml
Type: String
Parameter Sets: Community
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetUsers
{{ Fill SetUsers Description }}

```yaml
Type: SwitchParameter
Parameter Sets: V3
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserPass
{{ Fill UserPass Description }}

```yaml
Type: String
Parameter Sets: V3
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
{{ Fill UserName Description }}

```yaml
Type: String
Parameter Sets: V3
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableSNMP
{{ Fill DisableSNMP Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-snmp

## RELATED LINKS
