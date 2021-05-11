---
external help file: SCPSMeraki-help.xml
Module Name: SCPSMeraki
online version:
schema: 2.0.0
---

# Set-SCMrkAuth

## SYNOPSIS
Cmdlet for connecting to Meraki Dashboard API.

## SYNTAX

```
Set-SCMrkAuth [-ApiKey] <String> [[-OrgId] <String>] [<CommonParameters>]
```

## DESCRIPTION
Cmdlet whitch which will authenticate your API key with Meraki Dashboard
The cmdlet is necessary for not having to provide the API Key for the
follwing cmdlets you will use.

## EXAMPLES

### EXAMPLE 1
```
Set-SCMrkAuth -ApiKey "<api_key>"
```

This example will connect to the Meraki Dashboard API.
If you have multiple Organisations
attached to your API key, the cmdlet will atumatically connect you to the firs Organisation.

### EXAMPLE 2
```
Set-SCMrkAuth -ApiKey "<api_key>" -OrgId "<organisation_id>"
```

This examplel will connect you to the Merakii Dashboard API, and to the specific organisation
specified with the parameter OrgId

## PARAMETERS

### -ApiKey
ApiKey for Meraki Dashboard.
Check following Meraki Docs to see how to get a Dashboard API Key:
https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -OrgId
Organisation Id for the specific Organisation you want to connect to.
If you only have a single
organisation, you can skip this parameter.
If you have multiple Organisations but don't provide
an organisation id the cmdlet will automatically connect you to the first organisation it
retrieves.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[] - You can pipe the ApiKey as a string into the cmdlet
## OUTPUTS

### System.String[] - The cmdlet returns a string with successfull statement, if connection was successfull
## NOTES
n/a

## RELATED LINKS

[Online Help: https://scriptingchris.tech]()

