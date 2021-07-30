---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkSwitchPort

## SYNOPSIS
Short description

## SYNTAX

### access
```
Set-SCMrkSwitchPort [-ApiKey <String>] -Serial <String> -PortId <String> -Name <String> [-Enabled <Boolean>]
 [-poeEnabled <Boolean>] -Vlan <String> [-VoiceVlan <String>] [-isolationEnabled <Boolean>]
 [-rstpEnabled <Boolean>] [-stpGuard <String>] [-LinkNegotiation <String>] [-udld <String>] [-AccessPort]
 [-AccessPolicy <String>] [<CommonParameters>]
```

### trunk
```
Set-SCMrkSwitchPort [-ApiKey <String>] -Serial <String> -PortId <String> -Name <String> [-Enabled <Boolean>]
 [-poeEnabled <Boolean>] -Vlan <String> [-VoiceVlan <String>] [-isolationEnabled <Boolean>]
 [-rstpEnabled <Boolean>] [-stpGuard <String>] [-LinkNegotiation <String>] [-udld <String>] [-TrunkPort]
 [-AllowedVlans <String>] [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
<example usage>
Explanation of what the example does
```

## PARAMETERS

### -ApiKey
Default Cmdlet Parameters

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
Default Switch Port Parameters

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

### -PortId
{{ Fill PortId Description }}

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

### -Name
Enter descriptive name of the port

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

### -Enabled
{{ Fill Enabled Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -poeEnabled
{{ Fill poeEnabled Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VoiceVlan
{{ Fill VoiceVlan Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isolationEnabled
{{ Fill isolationEnabled Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -rstpEnabled
{{ Fill rstpEnabled Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -stpGuard
{{ Fill stpGuard Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Disabled
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinkNegotiation
{{ Fill LinkNegotiation Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Auto negotiate
Accept pipeline input: False
Accept wildcard characters: False
```

### -udld
{{ Fill udld Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Alert only
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessPort
Default Access Port Parameters

```yaml
Type: SwitchParameter
Parameter Sets: access
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessPolicy
{{ Fill AccessPolicy Description }}

```yaml
Type: String
Parameter Sets: access
Aliases:

Required: False
Position: Named
Default value: Open
Accept pipeline input: False
Accept wildcard characters: False
```

### -TrunkPort
Default Trunk Port Parameters

```yaml
Type: SwitchParameter
Parameter Sets: trunk
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedVlans
{{ Fill AllowedVlans Description }}

```yaml
Type: String
Parameter Sets: trunk
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Inputs (if any)
## OUTPUTS

### Output (if any)
## NOTES
General notes

## RELATED LINKS
