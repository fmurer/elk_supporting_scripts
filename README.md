# Supporting Scripts

This repository contains scripts to support the use of and digital forensic investigations with (SOF-)ELK

## Requirements

* ELK stack with Logstash configured to expect input from Winlogbeat (in the example below, Logstash has a beats input listening on port 5045).

## Usage
### Load Acquired EVTX Files to ELK
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
### Load, Convert and Import Sigma-Rules to Kibana
```bash
[elk_user@sof-elk elk_supporting_scripts]$ ./import_sigma_searches.sh
[+]  ----------------------------------------- Clone Current Sigma Rules -----------------------------------------
Cloning into '/tmp/sigma'...
remote: Enumerating objects: 57689, done.
remote: Counting objects: 100% (759/759), done.
remote: Compressing objects: 100% (392/392), done.
remote: Total 57689 (delta 523), reused 548 (delta 367), pack-reused 56930
Receiving objects: 100% (57689/57689), 19.74 MiB | 15.01 MiB/s, done.
Resolving deltas: 100% (44388/44388), done.
[+]  ----------------------------------------- Install SigmaTools -----------------------------------------
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: sigmatools in /home/elk_user/.local/lib/python3.6/site-packages (0.19.1)
Requirement already satisfied: pymisp in /home/elk_user/.local/lib/python3.6/site-packages (from sigmatools) (2.4.152)
Requirement already satisfied: progressbar2 in /home/elk_user/.local/lib/python3.6/site-packages (from sigmatools) (3.55.0)
Requirement already satisfied: PyYAML in /usr/local/lib64/python3.6/site-packages (from sigmatools) (5.2)
Requirement already satisfied: six in /usr/lib/python3.6/site-packages (from progressbar2->sigmatools) (1.14.0)
Requirement already satisfied: python-utils>=2.3.0 in /home/elk_user/.local/lib/python3.6/site-packages (from progressbar2->sigmatools) (2.6.3)
Requirement already satisfied: python-dateutil<3.0.0,>=2.8.2 in /home/elk_user/.local/lib/python3.6/site-packages (from pymisp->sigmatools) (2.8.2)
Requirement already satisfied: requests<3.0.0,>=2.26.0 in /home/elk_user/.local/lib/python3.6/site-packages (from pymisp->sigmatools) (2.26.0)
Requirement already satisfied: jsonschema<4.0.0,>=3.2.0 in /usr/local/lib/python3.6/site-packages (from pymisp->sigmatools) (3.2.0)
Requirement already satisfied: deprecated<2.0.0,>=1.2.13 in /home/elk_user/.local/lib/python3.6/site-packages (from pymisp->sigmatools) (1.2.13)
Requirement already satisfied: wrapt<2,>=1.10 in /home/elk_user/.local/lib/python3.6/site-packages (from deprecated<2.0.0,>=1.2.13->pymisp->sigmatools) (1.13.3)
Requirement already satisfied: attrs>=17.4.0 in /usr/local/lib/python3.6/site-packages (from jsonschema<4.0.0,>=3.2.0->pymisp->sigmatools) (20.3.0)
Requirement already satisfied: setuptools in /usr/local/lib/python3.6/site-packages (from jsonschema<4.0.0,>=3.2.0->pymisp->sigmatools) (56.0.0)
Requirement already satisfied: pyrsistent>=0.14.0 in /usr/local/lib64/python3.6/site-packages (from jsonschema<4.0.0,>=3.2.0->pymisp->sigmatools) (0.17.3)
Requirement already satisfied: importlib-metadata in /usr/local/lib/python3.6/site-packages (from jsonschema<4.0.0,>=3.2.0->pymisp->sigmatools) (3.4.0)
Requirement already satisfied: certifi>=2017.4.17 in /usr/local/lib/python3.6/site-packages (from requests<3.0.0,>=2.26.0->pymisp->sigmatools) (2019.11.28)
Requirement already satisfied: idna<4,>=2.5 in /usr/local/lib/python3.6/site-packages (from requests<3.0.0,>=2.26.0->pymisp->sigmatools) (2.8)
Requirement already satisfied: charset-normalizer~=2.0.0 in /home/elk_user/.local/lib/python3.6/site-packages (from requests<3.0.0,>=2.26.0->pymisp->sigmatools) (2.0.9)
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /usr/local/lib/python3.6/site-packages (from requests<3.0.0,>=2.26.0->pymisp->sigmatools) (1.25.7)
Requirement already satisfied: zipp>=0.5 in /usr/local/lib/python3.6/site-packages (from importlib-metadata->jsonschema<4.0.0,>=3.2.0->pymisp->sigmatools) (3.4.0)
Requirement already satisfied: typing-extensions>=3.6.4 in /usr/local/lib/python3.6/site-packages (from importlib-metadata->jsonschema<4.0.0,>=3.2.0->pymisp->sigmatools) (3.7.4.3).
[+]  ----------------------------------------- Convert Windows Rules to Searches -----------------------------------------
[+]  Created - /tmp/sigma/rules/windows/builtin/application/win_audit_cve.yml
[+]  Created - /tmp/sigma/rules/windows/builtin/application/win_av_relevant_match.yml
[... snip ...]
```
