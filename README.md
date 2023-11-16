# Scripts-Utils-Windows
Colección de scripts útiles para Windows
# Listado
 - clean_temp.ps1: limpia los archivos temporales más antiguos que 7 días de Windows, .NET y de SQL Server.
 ### Modo de uso
	Descargar y ejecutar desde Powershell

 - import-firewall-allow.ps1: crea reglas de Allow (entrada) en el Firewall de Windows para países y puertos específicos. Se puede usar para "cerrar" el tráfico a un país específico.

 - install_ad.ps1: Instala y configura Active Directory
 
### Modo de uso
Agregar país (en el ejemplo sería "ar" - Argentina -) a lista blanca de entrada (por defecto sólo lo hace en estos puertos TCP: 25,80,110,143,443,587,993,995,1433): 

	.\import-firewall-allow.ps1 ar
Eliminar las reglas:

	.\import-firewall-blocklist.ps1 ar -deleteonly
Agregar país a lista blanca en puertos específicos:
	
	.\import-firewall-blocklist.ps1 ar -ports "80,443"
