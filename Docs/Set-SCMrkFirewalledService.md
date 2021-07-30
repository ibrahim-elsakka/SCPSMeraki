---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkFirewalledService

## SYNOPSIS
Cmdlet for setting a firewalled service on a specified network

## SYNTAX

```
Set-SCMrkFirewalledService [-Id] <String> [[-ApiKey] <String>] [-Service] <String> [-Access] <String>
 [[-AllowedIPs] <Array>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will configure a firewalled service on a network.
You can configure the
services: web, SNMP and ICMP.
You can configure the service to be either: blocked, restricted or unrestricted.

## EXAMPLES

### EXAMPLE 1
```
Set-SCMrkFirewalledService -Id $Id -Service "SNMP" -Access "restricted" -AllowedIPs @("10.245.0.23", "10.232.45.90")
```

This example will set the service SNMP on the network $Id to be restricted and only the IPs 10.245.0.23 and 10.232.45.90
Will have access to that service.

### EXAMPLE 2
```
Set-SCMrkFirewalledService -Id $Id -Service "web" -Access "blocked"
```

This example will set the service web to be blocked for the network

### EXAMPLE 3
```
Set-SCMrkFirewalledService -Id $Id -Service "ICMP" -Access "unrestricted"
```

This will set the service ICMP to be allowed by any remote IP addresses over the internet

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
Can be either: ICMP, web or SNMP

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

### -Access
Can be either: blocked, restricted, unrestricted

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedIPs
Array of IP addresses

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-firewall-firewalled-service

## RELATED LINKS
