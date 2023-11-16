$NewHostname = Read-Host -Prompt 'Hostname del equipo (ej: vps.dominio.com) '
if($NewHostname -notmatch '^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$') {
    throw "Hostname erróneo"
}
$NHArray = $NewHostname.split(".")
$suffix = $NHArray[0]
$domain = $NewHostname.Replace($suffix + ".", "")
$netbiosName = $NewHostname.Replace(".", "")

echo "Se usará hostname $NewHostname"
echo ""

echo "Instalando Active Directory..."
Install-WindowsFeature -Name AD-Domain-Services, RSAT-AD-Tools -IncludeManagementTools

echo "Desactivando reglas de Firewall..."
Disable-NetFirewallRule -DisplayGroup "Active Directory Domain Services"

echo "Configurando Active Directory..."

Rename-Computer -NewName "$suffix" -Force -ErrorAction SilentlyContinue
 
Import-Module ADDSDeployment
Install-ADDSForest `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "$domain" `
-DomainNetbiosName "$netbiosName" `
-ForestMode "WinThreshold" `
-InstallDns:$false `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

