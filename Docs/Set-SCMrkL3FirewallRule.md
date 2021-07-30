---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkL3FirewallRule

## SYNOPSIS
Cmdlet for adding a new L3 firewall rule to a network

## SYNTAX

```
Set-SCMrkL3FirewallRule [-Id] <String> [[-ApiKey] <String>] [-Comment] <String> [-Policy] <String>
 [-Protocol] <String> [-SourcePort] <String> [-SourceAddress] <String> [-DestinationPort] <String>
 [-DestinationAddress] <String> [[-SyslogEnabled] <String>] [[-PlaceOnTop] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will query all the existing L3 firewall rules and add a new rule to the list.
You can chose to place the rule either on top or in the bottom of the list.

## EXAMPLES

### EXAMPLE 1
```
$SplatArgs = @{
    Comment = "TEST - Allow snmp"
    Policy = "allow"
    Protocol = "udp"
    SourcePort = "161"
    SourceAddress = "any"
    DestinationPort = "161"
    DestinationAddress = "192.168.137.1"
    PlaceOnTop = $true
}
Set-SCMrkL3FirewallRule -Id $id @SplatArgs -Verbose
```

This example will create a new firewall named "TEST - Allow snmp" In this example the rule is beeing
passed to the cmdlet with splatting.
You can also run the cmdlet in the conventional way.
In this specific example the new rule will be placed in the top of all the rules.
To specify that the 
rule should be placed in the bottom you can define -PlaceOnTop as $false or not define it at all.

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

### -Comment
{{ Fill Comment Description }}

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

### -Policy
{{ Fill Policy Description }}

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

### -Protocol
{{ Fill Protocol Description }}

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

### -SourcePort
{{ Fill SourcePort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceAddress
{{ Fill SourceAddress Description }}

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

### -DestinationPort
{{ Fill DestinationPort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationAddress
{{ Fill DestinationAddress Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyslogEnabled
{{ Fill SyslogEnabled Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlaceOnTop
{{ Fill PlaceOnTop Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-firewall-l-3-firewall-rules

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

