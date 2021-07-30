---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkNetworkDevices

## SYNOPSIS
Cmdlet for retrieving all (meraki)devices on a network

## SYNTAX

```
Get-SCMrkNetworkDevices [-Id] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet which will retrieve a PS Object with an array of all the networks claimed and added
to a specific network

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkDevices -Id "<network_id>"
```

This example will retrive all the networks located on the network with the "\<network_id\>" you
provided the in the parameter Id.

### EXAMPLE 2
```
(Get-SCMrkNetworks | ? Name -eq "Network1").Id | Get-SCMrkNetworkDevices
```

This example will grap the id of the network with name "Network1" through the pipeline and
return all the (network)devices on that specific network.

## PARAMETERS

### -Id
Network Id from the network you want to retrive the devices from.

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

### System.String[] - You can pipe the Id(network id) into the cmdlet
## OUTPUTS

### System.Array[] - The cmdlet will output an PS Object with an array of all the devices on the network.
## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-devices

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

