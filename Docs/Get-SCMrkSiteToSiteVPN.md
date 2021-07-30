---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkSiteToSiteVPN

## SYNOPSIS
This cmdlet will retrieve all Site To Site VPN configurations on a network

## SYNTAX

```
Get-SCMrkSiteToSiteVPN [-Id] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will return an object containing all data regarding Site To Site configuration
for a specific network

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkSiteToSiteVPN -Id $Id
```

This example will retrieve the Site To Site configurations for the Network $id

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
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-vpn-site-to-site-vpn

## RELATED LINKS
