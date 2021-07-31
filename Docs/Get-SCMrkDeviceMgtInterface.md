---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkDeviceMgtInterface

## SYNOPSIS
Cmdlet for retrieving information on Device Management Interface

## SYNTAX

```
Get-SCMrkDeviceMgtInterface [-Serial] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will return an  Object containing configuration information
on the Device Management interface of a specified device.

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkDeviceManagementInterface -Serial QXLA-23BA-LS98
```

This example will retrive the configurations made for the Device Management interface
on the device: QXLA-23BA-LS98

## PARAMETERS

### -Serial
{{ Fill Serial Description }}

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
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-device-management-interface

## RELATED LINKS
