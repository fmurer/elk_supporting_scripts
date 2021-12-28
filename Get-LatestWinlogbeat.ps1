function Get-LatestWinlogbeat {
    #$WINLOGBEAT_VERSION = Read-Host "[+] Current Version of Winlogbeat"
    $WINLOGBEAT_VERSION = "7.15.2"
    $WINLOGBEAT_URL = "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-$WINLOGBEAT_VERSION-windows-x86_64.zip"

    Write-Host "[+] Downloading $WINLOGBEAT_URL"
    Invoke-WebRequest -Uri $WINLOGBEAT_URL -OutFile $PWD/winlogbeat.zip

    Write-Host "[+] Extracting ZIP"
    Expand-Archive -Path $PWD/winlogbeat.zip -DestinationPath $PWD/winlogbeat
    
    Write-Host "[+] Cleanup."
    Remove-Item $PWD/winlogbeat.zip
    Move-Item $PWD/winlogbeat/winlogbeat-$WINLOGBEAT_VERSION-windows-x86_64/* $PWD/winlogbeat/
    Remove-Item $PWD/winlogbeat/winlogbeat-$WINLOGBEAT_VERSION-windows-x86_64
}

Get-LatestWinlogbeat