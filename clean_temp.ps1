# Delete all Files older than 7 day(s)
$tempfolders = @("C:\Windows\Temp\", "C:\Documents and Settings\*\Local Settings\temp\", "C:\Users\*\Appdata\Local\Temp\", "C:\Windows\System32\LogFiles\HTTPERR", "C:\Windows\Microsoft.NET\Framework*\v*\Temporary ASP.NET Files" , "C:\Inetpub\vhosts\*\httpdocs\App_Data\cache\", "C:\Inetpub\vhosts\*\httpdocs\App_Data\Temp\", "C:\Windows\CbsTemp")

# Delete these files directly
$tempfiles = @("C:\Program Files*\Plesk\Databases\MSSQL\*\MSSQL\Log\ERRORLOG*", "C:\Program Files\Microsoft SQL Server\MSSQL*.MSSQLSERVER\MSSQL\Log\SQLDump*", "C:\Program Files*\Plesk\Databases\MSSQL\*\MSSQL\Log\SQLDump*", "C:\Program Files*\Microsoft SQL Server\*\MSSQL\Log\ERRORLOG*")

$Daysback = "-7"
 
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
$ErrorActionPreference = "silentlycontinue"

foreach($folder in $tempfolders) {
	echo "Procesando carpeta $folder..."
	Get-ChildItem $folder -Recurse -ErrorAction SilentlyContinue -Force | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item -Recurse -ErrorAction SilentlyContinue
}

echo "Parando servicio de MSSQL..."
Stop-Service -Name "MSSQL*"

foreach($file in $tempfiles) {
	echo "Procesando archivo $file..."
	Get-ChildItem -Path "$file" | Remove-Item -ErrorAction SilentlyContinue
}

echo "Levantando servicio de MSSQL..."
Start-Service -Name "MSSQL*"

echo "Listo!"
