---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkClient

## SYNOPSIS
Cmdlet for retrieving data on a specific client

## SYNTAX

```
Get-SCMrkClient [-Id] <String> [-ClientId] <String> [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet which retrieves a PS Object with data on a specific client on a specific network

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkClient -Id "<network_id>" -ClientId "<client_id>"
```

This cmdlet will retrieve a PS Object on a specific client, defined by the -ClientId,
on a specific Network defined by -Id

## PARAMETERS

### -Id
Network Id for the network which the client is associated with

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ClientId
Client Id of the client you want to retrieve data on

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
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

### System.String[] - You can pipe the Id (network id) into the cmdlet
### System.String[] - You can pipe the ClientId (Client Id) into the cmdlet
## OUTPUTS

### System.Object[] - This cmdlet will output a PS Object with data on the specific client defined.
## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-client

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

