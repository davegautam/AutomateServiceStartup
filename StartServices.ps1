#set the Security Principal to Administrator
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

#Name of the services you need or need to start
$services="w3C Logging Service","world wide web publishing service","IIS Admin service","Net.Tcp Listener Adapter","Net.Tcp Port Sharing Service","Net.Pipe Listener Adapter","SQL Server (MSSQLSERVER)","SQL server agent (MSSQLSERVER)"

Write-Host -ForegroundColor Red "Starting Services"

$success=$true

	foreach($service in $services)
	{
		$currentservice = get-service $service
		
    	#check the service status
		if ($currentservice.Status -eq "Stopped") 
		{
			Write-Host -ForegroundColor Red $currentservice.name "Service Faliure"
			Write-Host -ForegroundColor Yellow "Attempting to start" $currentservice.name 
		
			try
			{
			  #start the service
				Start-Service $currentservice -ea Stop
			}
			catch 
			{
				if ( $error[0].Exception -match "Microsoft.PowerShell.Commands.ServiceCommandException")
				{
					Write-Host -ForegroundColor Red  $currentservice.name "could not be started.Make sure you have administrative privileges."
					$success=$false
				}
			}
			
			if($currentservice.Status -eq "Running")
			{
				Write-Host -ForegroundColor Yellow $currentservice.name "Service Started"
			}
		}
	}
	if($success)
	{
		Write-Host -ForegroundColor Yellow "All services are running."
	}
	else
	{
		Write-Host -ForegroundColor Red "All services could not be started."
	}


Read-Host -Prompt "Press Enter to exit"


