$date = Get-Date
$body = Get-ADUser -Filter {department -like "*" } -SearchBase "OU=zzTest,DC=PL,DC=tenant_name,DC=info" -Properties * |where -Property Enabled -eq $true |where AccountExpirationDate -lt $date| Select-Object cn,AccountExpirationDate, @{Label='ExpiresNext(n)Days';Expression={($_.AccountExpirationDate -(Get-Date).Date).Days -le 0}}, Enabled, Manager 
$sub =  Get-ADUser -Filter {department -like "*" } -SearchBase "OU=zzTest,DC=PL,DC=tenant_name,DC=info" -Properties * |where -Property Enabled -eq $true |where AccountExpirationDate -lt $date| Select-Object Name
$subject = “ New disable users”
if($body) {
        $a = Get-ADUser -Filter {department -like "*" } -SearchBase "OU=zzTest,DC=PL,DC=tenant_name,DC=info" -Properties * |where -Property Enabled -eq $true |where AccountExpirationDate -lt $date

        ForEach-Object {
		 $a | Disable-ADAccount

	} 
    
    Send-MailMessage -to 'your_email@domain.com' -from 'your_email@domain.com' -Subject $subject -body ( $body | out-string ) -SmtpServer your_company_mail_link -Port 25 

}
Else {
        Write-Host "Not working!"
}