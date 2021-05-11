---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkSwitchPort

## SYNOPSIS
Cmdlet for retriving confiurations on a switch port

## SYNTAX

```
Get-SCMrkSwitchPort [-Serial] <String> [-PortId] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet for retriving configurations on a specific Meraki Switch port.

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkSwitchPort -Serial "<serial_number>" -PortId "<port_id>"
```

This example will retrieve the configurations on a specific Meraki switch port.

### EXAMPLE 2
```
(Get-SCMrkDevices -Id "<network_id>" | ? Name -eq "Device1").Serial | Get-SCMrkswitchPort -PortId 1
```

This example will grap the serial from the pipeline and retrieve the configuratoins on switch port 1

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

### -PortId
The port id on the Meraki switch

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Position: 3
Default value: $ApiKey
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[] - You can pipe the Serial into the cmdlet
### System.String[] - You can pipe the PortId into the cmdlet
## OUTPUTS

### System.Object[] - This cmdlet will output a PS Object with data on the Switch port
## NOTES
https://developer.cisco.com/meraki/api-v1/#!get-device-switch-port

## RELATED LINKS
