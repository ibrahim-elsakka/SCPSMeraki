---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkAppliancePort

## SYNOPSIS
Cmdlet for retrieving data on a specific MX Appliance port in a Network

## SYNTAX

```
Get-SCMrkAppliancePort [-Id] <String> [[-ApiKey] <String>] [-PortId] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will retrieve an Object with configuration data on a specific MX
appliance port

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkAppliancePorts -Id $id -Port 1
```

This example will retrieve data on port 1 on the MX appliance in the network: $id

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

### -PortId
{{ Fill PortId Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-port

## RELATED LINKS
