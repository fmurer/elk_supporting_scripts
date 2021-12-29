# Checks if the log folder already exists otherwise create it
function Prepare-Upload {
    $log_folder = "$PWD\logs"
    $winlogbeat_folder = "$PWD\winlogbeat"

    if (!(Test-Path -Path $log_folder)) {
        Write-Host "[!] Log folder does not exist, creating folder $log_folder."
        New-Item -ItemType Directory -Force -Path $log_folder
    } else {
        Write-Host "[+] Log folder $log_folder already exists."
    }

    if (!(Test-Path -Path $winlogbeat_folder)) {
        . .\Get-LatestWinlogbeat.ps1
    }

    Copy-Item .\config\winlogbeat.yml .\winlogbeat\winlogbeat.yml
}

# Load one single EVTX file to the defined Logstash-Endpoint
# The endpoint will be defined in the config file `.\winlogbeat\winlogbeat.yml`
function Load-EVTXFile {
    param(
        $evtx_file,
        $sof_elk
    )
    # Get current date for logging
    $date = Get-Date -UFormat "%m-%d"

    .\winlogbeat\winlogbeat.exe -e -c .\winlogbeat\winlogbeat.yml -E EVTX_FILE="$evtx_file" -E SOF_ELK="$sof_elk" 2>&1 >> $PWD\logs\winlogbeat_log_${date}.log
}

# Recursively go through a directory and upload every EVTX file
function Load-EVTXDir {
    param(
        $evtx_dir,
        $sof_elk
    )

    # $folders = Get-ChildItem -Path $evtx_dir -Directory | % {$_.FullPath}
    $folders = Get-ChildItem -Path $evtx_dir -Directory | Select -ExpandProperty FullName

    # Loop through every folder recursively
    foreach($folder in $folders) {
        Load-EVTXDir $folder 
    }

    $counter = 1

    # $files = Get-ChildItem -Path $folder -filter *.evtx | % {$_.FullPath}
    $files = Get-ChildItem -Path $evtx_dir -filter *.evtx | Select -ExpandProperty FullName
    $file_count = $files.Count 

    # Upload each file
    foreach($file in $files) {
        # Progress Bar
        $complete = ($counter / $file_count) * 100
        Write-Progress -Activity "$counter of $file_count EVTX files in $evtx_dir sent to ELK" -Status "Uploading $file ..." -PercentComplete $complete

        # Load file
        Load-EVTXFile $file $sof_elk

        Start-Sleep 3
        $counter++
    }
}

# Welcome Banner
Write-Host "#####################################################################################################################"
Write-Host "SOF-ELK EVTX UPLOAD SCRIPT | v1.0"
Write-Host "Fabian Murer | @f_Murer (based on a script created by @zmbf0r3ns1cs)"
Write-Host "Source: https://burnhamforensics.com/2019/11/19/manually-upload-evtx-log-files-to-elk-with-winlogbeat-and-powershell/"
Write-Host "#####################################################################################################################"
Write-Host ""

# Prepare Environment
Write-Host "[+] Prepare environment"
Prepare-Upload
Write-Host ""

# Ask for the SOF-ELK Server
Write-Host "[+] Enter the IP:Port combination of the SOF-ELK server."
$sof_elk = Read-Host "[+] SOF-ELK"
Write-Host ""

# Ask for a path containing EVTX logs
Write-Host "[+] Enter target directory path containing EVTX logs."
$evtx_path = Read-Host "[+] Path"

# Load EVTX Files
Load-EVTXDir $evtx_path $sof_elk

# Show message confirming successful upload
Write-Host ""
Write-Host "[*] EVTX Upload completed. Use the 'Discover' tab in Kibana to view."
