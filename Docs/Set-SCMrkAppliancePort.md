---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkAppliancePort

## SYNOPSIS
Cmdlet for configuring a single port on a MX appliance

## SYNTAX

```
Set-SCMrkAppliancePort [-Id] <String> [[-ApiKey] <String>] [-PortId] <String> [[-Enabled] <Boolean>]
 [-Vlan] <String> [[-DropUntaggedTraffic] <Boolean>] [-Type] <String> [[-AccessPolicy] <String>]
 [[-AllowedVlans] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will configure a single port on a MX appliance as either an Accsess port or a Trunk port.

## EXAMPLES

### EXAMPLE 1
```
Set-SCMrkAppliancePort -id $id -PortId 5 -Type "access" -vlan 30
```

This example will configure port 5 as an access port and set it to VLAN 30

### EXAMPLE 2
```
Set-SCMrkAppliancePort -id $id -PortId 5 -Type "trunk" -vlan 1 -AllowedVlans "10,20,30,400,555"
```

This example will configure port 5 as a trunk and set the native vlan to be 1 and allow the vlans:
10,20,30,400,555 to be tagged on the trunk.

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

### -PortId
Enter the port number of the port you want to configure

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

### -Enabled
{{ Fill Enabled Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -Vlan
Enter a VLAN Id

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DropUntaggedTraffic
{{ Fill DropUntaggedTraffic Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Enter a Type: trunk or access

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessPolicy
{{ Fill AccessPolicy Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: Open
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedVlans
A comma seperated string with the vlans or type all to allow all vlans

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-port

## RELATED LINKS
