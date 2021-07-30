---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkL3FirewallRules

## SYNOPSIS
Cmdlet for retrieving all L3 firewall rules for a network

## SYNTAX

```
Get-SCMrkL3FirewallRules [-Id] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will return an Array of all L3 firewall rules configured on a network

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkL3FirewallRules -Id L_918231134598135
```

This example will return all L3 firewall rules configured for the network with Id
L_918231134598135.

## PARAMETERS

### -Id
{{ Fill Id Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
Position: 2
Default value: $ApiKey
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-firewall-l-3-firewall-rules

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

