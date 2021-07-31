---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkDeviceMgtInterface

## SYNOPSIS
Cmdlet for setting the Management Interface on Meraki Devices

## SYNTAX

### dhcp
```
Set-SCMrkDeviceMgtInterface [-ApiKey <String>] -Serial <String> -Interface <String> -ManagementVlan <String>
 [-UseDHCP] [<CommonParameters>]
```

### static
```
Set-SCMrkDeviceMgtInterface [-ApiKey <String>] -Serial <String> -Interface <String> -ManagementVlan <String>
 [-UseStaticIP] -StaticIpAddress <String> -SubnetMask <String> -DefaultGateway <String> -DNSServers <Array>
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet can be used for setting the Manamgenet Interface on a specified Meraki
Device.
You can chose to set the interface as DHCP or by setting a static Ip address.

## EXAMPLES

### EXAMPLE 1
```
$InterfaceArgs = @{
            Serial = $serial
            Interface = "wan1"
            ManagementVlan = "20"
            StaticIpAddress = "192.168.1.2"
            SubnetMask = "255.255.255.0"
            DefaultGateway = "192.168.1.1"
            DNSServers = @(
                "8.8.8.8",
                "8.8.4.4"
            )
        }
```

PS C:\\\> Set-SCMrkDeviceMgtInterface -UseStaticIP @InterfaceArgs

This example will use splatting to configure the management interface on the device defined by the serial number
$serial.
The example will configure the interface to use a Static IP address defined by the switch parameter: -UseStaticIP.
It will then use the information passed in the splat to configure the interface.

### EXAMPLE 2
```
Set-SCMrkDeviceMgtInterface -Serial $serial -Interface "wan1" -ManagementVlan 1 -UseDHCP
```

This example will configure the management interface on the device defined by the $serial variable.
It will
configure the device to use DHCP for configuring the interface.

## PARAMETERS

### -ApiKey
{{ Fill ApiKey Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $ApiKey
Accept pipeline input: False
Accept wildcard characters: False
```

### -Serial
{{ Fill Serial Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Interface
Chose either wan1 or wan2

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagementVlan
Choose a vlan between 1-1024

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDHCP
{{ Fill UseDHCP Description }}

```yaml
Type: SwitchParameter
Parameter Sets: dhcp
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseStaticIP
{{ Fill UseStaticIP Description }}

```yaml
Type: SwitchParameter
Parameter Sets: static
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -StaticIpAddress
Set the Ip address of the interface

```yaml
Type: String
Parameter Sets: static
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubnetMask
Set the subnet mask of the interface

```yaml
Type: String
Parameter Sets: static
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultGateway
Set the default gateway for the interface

```yaml
Type: String
Parameter Sets: static
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DNSServers
Array containing DNS Ip addresses

```yaml
Type: Array
Parameter Sets: static
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-device-management-interface

## RELATED LINKS
