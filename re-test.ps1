

if($ApiKey){
    try {
        Write-Output "Removing Module SCPSMeraki"
        Remove-Module SCPSMeraki
    }
    catch {
        Write-Warning "Couldn't remove the module SCPSMeraki"
    }
    
    
    sleep -s 1
    
    Write-Output "Building new Module Debug-Version"
    Invoke-Build -File ./build.ps1 -Configuration "debug"
    
    sleep -s 1
    
    Write-Output "Importing Module"
    $version = (Get-ChildItem "./Output/temp/SCPSMeraki").Name
    $modulePath = "./Output/temp/SCPSMeraki/$($version)/SCPSMeraki.psm1"
    Import-Module $modulePath
    
    sleep -s 1
    
    Set-SCMrkAuth -ApiKey $ApiKey
}
else {
    Write-Warning "No api key variable was found..."
}