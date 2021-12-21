<powershell>
$source = 'https://vstsagentpackage.azureedge.net/agent/2.195.2/vsts-agent-win-x64-2.195.2.zip'
$destination = 'C:\Users\Administrator\Downloads\vsts-agent-win-x64-2.195.2.zip'
echo "Downloading the file"
Invoke-WebRequest -Uri $source -OutFile $destination
mkdir C:\Users\Administrator\Downloads\agent
cd C:\Users\Administrator\Downloads\agent
Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("C:\Users\Administrator\Downloads\vsts-agent-win-x64-2.195.2.zip", "$PWD")

.\config.cmd --unattended --url ${VSTS_AGENT_INPUT_URL} --auth pat --token ${VSTS_AGENT_INPUT_TOKEN} --pool ${VSTS_AGENT_INPUT_POOL} --runAsService --windowsLogonAccount "NT AUTHORITY\SYSTEM"
</powershell>