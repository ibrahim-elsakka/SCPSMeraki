---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkFirewalledService

## SYNOPSIS
Cmdlet for retrieving a specified firewalled service from a network

## SYNTAX

```
Get-SCMrkFirewalledService [-Id] <String> [[-ApiKey] <String>] [-Service] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will retrieve information on a specific firewalled service on a network.
It will retrieve information such as Access policy, Allowed IPs.

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkFirewalledService -Id $Id -Service "SNMP"
```

This example will retrieve a PowerShell object containing configurations for the SNMP firewalled service
on a specific network

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

### -Service
{{ Fill Service Description }}

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
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-firewall-firewalled-service

## RELATED LINKS
