---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkAppliancePorts

## SYNOPSIS
Cmdlet for retrieving all appliance ports from a specified network

## SYNTAX

```
Get-SCMrkAppliancePorts [-Id] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will retrieve an object containing configuration data on all the ports
on a MX appliance.

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkAppliancePorts -Id $id
```

This example will retrieve information on all the ports on the MX appliance on the network $Id

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
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-ports

## RELATED LINKS
