#set the Security Principal to Administrator

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}


#add a trigger for job
#following trigger is scheduled to start 30 seconds after startup 
$trigger=New-JobTrigger -AtStartup -RandomDelay 00:00:30

#register the script with trigger
#Change this path F:\PowershellPractice\sageFlick.ps1 to you script path
#Change StartSageFlickTest2 to a sensible Job Name that suits you

Register-ScheduledJob -Trigger $trigger -FilePath F:\StartService\StartServices.ps1 -Name StartSageFlickTest2

Read-Host -Prompt "Press Enter to exit"
