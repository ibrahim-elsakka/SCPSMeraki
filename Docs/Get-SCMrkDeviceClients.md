---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkDeviceClients

## SYNOPSIS
Cmdlet for retrieving all clientes associated to a specific device

## SYNTAX

```
Get-SCMrkDeviceClients [-Serial] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will retrieve all the clients which are or have been connected to a specific device

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkDeviceClients -Serial "<serial_number>"
```

This example will return all the clients that are or have been connected, the last 24 hours,
to a specific Cisco Meraki device.

### EXAMPLE 2
```
(Get-SCMrkDevices -Id "<network_id>" | ? Name -eq "Device1").Serial | Get-SCMrkDeviceClients
```

This example will grap the serial fnumber from the pipeline and retrieve all the clients connected to the
specific device.

## PARAMETERS

### -Serial
The Serial number for a specific Cisco Meraki device.

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
ApiKey for Meraki Dashboard.
Check following Meraki Docs to see how to get a Dashboard API Key:
https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.

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

### System.String[] - You can pipe the Serial into the cmdlet
## OUTPUTS

### System.Array - The cmdlet will output an PS Object with an array of all the clients associated to a specific device.
## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-device-clients

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

