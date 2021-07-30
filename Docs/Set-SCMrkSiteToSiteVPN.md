---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkSiteToSiteVPN

## SYNOPSIS
Cmdlet for configuring Site To Site on a network

## SYNTAX

```
Set-SCMrkSiteToSiteVPN [-Id] <String> [[-ApiKey] <String>] [-Mode] <String> [[-HubId] <String>]
 [[-UseDefaultRoute] <Boolean>] [[-LocalSubnet] <String>] [[-UseVPN] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet which lets you configure Site To Site as either Spoke or Hub, or disable Site
To Site completely.

If a network is configured as a Spoke and you just want to set a subnet to be available on the VPN
you should just run the command as configuring a spoke with that specific subnet

## EXAMPLES

### EXAMPLE 1
```
Set-SCMrkSiteToSiteVPN -Id $id -HubId "L_6711231278931634675" -LocalSubnet "192.168.2.0/24" -UseVPN $true -Mode "spoke"
```

This example will configure the Site To Site as a spoke connecting to the Hub: L_6711231278931634675 and Configuring the local subnet
192.168.2.0/24 to be allowed on the VPN.

### EXAMPLE 2
```
Set-SCMrkSiteToSiteVPN -Id $id -Mode "hub"
```

This example will configure the Site To Site as a Hub

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

### -Mode
Can be none, spoke or hub

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

### -HubId
{{ Fill HubId Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultRoute
{{ Fill UseDefaultRoute Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LocalSubnet
{{ Fill LocalSubnet Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseVPN
{{ Fill UseVPN Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-vpn-site-to-site-vpn

## RELATED LINKS
