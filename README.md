# AutomateServiceStartup

Powershell scripts to automate the startup of services. If your application is dependent on some services, it would be better to automate the startup of such service which will be even handy when there are unplanned system restarts causing your services to start in next boot.

###StartServices.ps1
This script will start your services if the status of the services is stopped.

###StartupScript.ps1
  This script will add the StartServices.ps1with a trigger file to windows scheduler. By default, this scripts adds a trigger to execute      it with a 30 seconds delay in startup.



