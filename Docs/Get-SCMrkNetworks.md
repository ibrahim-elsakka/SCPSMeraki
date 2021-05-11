---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Get-SCMrkNetworks

## SYNOPSIS
Cmdlet for retrieving all networks in an Meraki Organisation.

## SYNTAX

```
Get-SCMrkNetworks [[-OrgId] <String>] [[-ApiKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will retrieve a powershell object with information on all
the networks in your Meraki Organisation.

## EXAMPLES

### EXAMPLE 1
```
Get-SCMrkNetworks -OrgId "<organisation_id>" -ApiKey "<api_key>"
```

This example will take an ApiKey and an Organisation Id and retrieve all networks
in that organisation.

### EXAMPLE 2
```
Get-SCMrkNetworks
```

If you have already run Set-SCMrkAuth, then you will not need to provide any
other parameters for retriving networks in that organisation you specified in
Set-MrkAuth.

## PARAMETERS

### -OrgId
Organisation id of the specific organisation you want to see the devices from.
If you have run Set-SCMrkAuth before running this cmdlet the parameter is not necessary.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $OrgId
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
Position: 2
Default value: $ApiKey
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[] - You can pipe OrgId as a string into the cmdlet.
## OUTPUTS

### System.Array[] - The cmdlet will output an PS Object with an array of all the networks.
## NOTES
Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-organization-networks

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

