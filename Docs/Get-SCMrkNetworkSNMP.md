---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkNetworkSNMP

## SYNOPSIS
Cmdlet for retrieving SNMP configurations of a network

## SYNTAX

```
Get-SCMrkNetworkSNMP [-Id] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will query a specific network and output the SNMP configurations from it

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkNetworkSNMP -Id L_918231134598135
```

This example will retrieve the SNMP configurations from the network L_918231134598135

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
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-snmp

## RELATED LINKS
