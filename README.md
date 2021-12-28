# Supporting Scripts

This repository contains scripts to support the use of and digital forensic investigations with (SOF-)ELK

## Requirements

* ELK stack with Logstash configured to expect input from Winlogbeat (in the example below, Logstash has a beats input listening on port 5045).

## Usage
```PowerShell
PS C:\elk_supporting_scripts> .\load_offline_evtx_to_elk.ps1
#####################################################################################################################
SOF-ELK EVTX UPLOAD SCRIPT | v1.0
Fabian Murer | @f_Murer (based on a script created by @zmbf0r3ns1cs)
Source: https://burnhamforensics.com/2019/11/19/manually-upload-evtx-log-files-to-elk-with-winlogbeat-and-powershell/
#####################################################################################################################

[+] Prepare environment
[+] Log folder C:\elk_supporting_scripts\logs already exists.
[+] Current Version of Winlogbeat: 7.15.2
[+] Downloading https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.15.2-windows-x86_64.zip
[+] Extracting ZIP
[+] Cleanup.

[+] Enter the IP:Port combination of the SOF-ELK server.
[+] SOF-ELK: 192.168.1.78:5045

[+] Enter target directory path containing EVTX logs.
[+] Path: C:\test_evtx

[*] EVTX Upload completed. Use the 'Discover' tab in Kibana to view.
```
