function Invoke-PRMerakiApiCall {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("POST", "GET", "PUT", "DELETE")]
        [String]$Method,
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [String]$Resource,
        [Parameter(Mandatory=$true)]
        [String]$ApiKey,
        [Parameter(Mandatory=$false)]
        [object]$Payload
    )

    begin {
        Write-Verbose -Message "Setting the API Key $($ApiKey) as a Script Varaible"
        New-Variable -Name ApiKey -Value $ApiKey -Scope Script -Force
        
        $baseUrl = "https://api.meraki.com/api/v1/"
        Write-Verbose -Message "Setting the base url: "

        $headers = @{
            "Content-Type" = "application/json"
            "Accept" = "application/json"
            "X-Cisco-Meraki-API-Key" = $ApiKey
        }
        Write-Verbose -Message "Setting the API Call headers"
    }

    process {
        if(!$Payload) {
            Write-Verbose -Message "Invoking the API call with uri: $($baseUrl)/$($Resource) and the Method: $($Method)"
            try {
                $result = Invoke-RestMethod -Uri $baseUrl/$Resource -Method $Method -Headers $headers
                return $result
            }
            catch {
                $statusCode = $_.Exception.Response.StatusCode.value__
                $statusDescription = $_.Exception.Response.StatusDescription
            }
        }
        elseif($Payload) {
            Write-Verbose -Message "Invoking the API call with uri: $($baseUrl)/$($Resource) and the Method: $($Method) with a Payload"
            $Body = $Payload | ConvertTo-Json
            if($Body){
                Write-Verbose "Payload was create. Sending HTTP Request"
                try {
                    $result = Invoke-RestMethod -Uri $baseUrl/$Resource -Method $Method -Headers $headers -Body $Body
                    return $result
                }
                catch {
                    Write-Error "$($_)"
                    $statusCode = $_.Exception.Response.StatusCode.value__
                    $statusDescription = $_.Exception.Response.StatusDescription
                }
            }
            else {
                Write-Warning "Payload couldn't be found"
            }
        }
    }

    end {
        if(!($result)){
            Write-Error -Message " HTTP Status Code: $($statusCode) - Error Description: $statusDescription"
        }
    }
}