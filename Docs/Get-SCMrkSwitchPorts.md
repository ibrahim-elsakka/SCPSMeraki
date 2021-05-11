---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkSwitchPorts

## SYNOPSIS
Cmdlet for retriving all Switch ports from a Meraki switch

## SYNTAX

```
Get-SCMrkSwitchPorts [-Serial] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet which retrieves configuration data on all switch ports of a Meraki Switch.

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkSwitchPorts -Serial "<serial_number>"
```

This example will retrieve data from all ports on a Meraki Switch.

### EXAMPLE 2
```
(Get-SCMrkDevices -Id "<network_id>" | ? Name -eq "Device1").Serial | Get-SCMrkSwitchPorts
```

This example will grap the Meraki Switch Serial number and pipe it into the cmdlet, to retrieve data
on all the Meraki switch ports.

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

### System.Object[] - This cmdlet will output a PS Object with data on the specific device.
## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-device-switch-ports

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

