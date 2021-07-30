---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkFirewalledServices

## SYNOPSIS
Cmdlet for retrieving firewalled services from a specific network

## SYNTAX

```
Get-SCMrkFirewalledServices [-Id] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will query a specified network and retrieve an object of firewalled
service

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkFirewalledServices -Id $Id
```

This example will retrieve a PowerShell object of all the firewalled services in a network

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
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-firewall-firewalled-services

## RELATED LINKS
