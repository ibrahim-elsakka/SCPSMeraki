---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkNetworkVlans

## SYNOPSIS
Cmdlet for retrieving all Network Vlans and Subnets.

## SYNTAX

```
Get-SCMrkNetworkVlans [-Id] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet which will retrieve an array of object containing each subnet or vlan configured on a
Meraki network.

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkNetworkVlans -Id L_918231134598135
```

This example will return an array of all the vlans configured on the network with
Id L_918231134598135.

### EXAMPLE 2
```
(Get-SCMrkNetworks | ? name -eq "TEST-NETWORK").Id | Get-SCMrkNetworkVlans
```

This example will pass the id of the network: TEST-NETWORK into the cmdlet Get-SCMrkNetworkVlans
and retrieve all the vlans for that specific network.

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

### System.String[] - You can pipe the Id(network id) into the cmdlet
## OUTPUTS

### System.Array[] - The cmdlet will output an PSObject with an array of all the vlans
## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-vlans

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

