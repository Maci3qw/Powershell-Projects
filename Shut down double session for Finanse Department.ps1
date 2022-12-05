$Processes = get-process Microsoft.Dynamics.Nav.Client -IncludeUserName
foreach ($ProcUser in $Processes.username)
{
if ($ProcUser -eq "domain_user") {continue}
get-process -name Microsoft.Dynamics.Nav.Client -IncludeUserName | Where UserName -EQ $ProcUser |sort starttime -Descending | select -Skip 1 | Stop-Process -Force
}