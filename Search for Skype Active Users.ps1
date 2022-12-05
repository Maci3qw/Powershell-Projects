Import-Module MSOnline 
Connect-MsolService -Credential $Office365credentials 
 
write-host "Connecting to Office 365..." 

$licensetype = Get-MsolAccountSku | Where {$_.ConsumedUnits -ge 1 -and $_.AccountSkuId -like "*SPB*"}


$Office365_Skype="MCOSTANDARD"


    foreach ($licenses in $licensetype) {
         #Write-Host $licences
         
            foreach($license_list in $licences.ServiceStatus) {
            $listin =  " --> " + $license_list.ServicePlan.ServiceName 
            #Write-Host  $listin
                 

            }
            $users = Get-MsolUser -all | where {$_.isLicensed -eq "True"  -and $_.licenses.accountskuid -contains $licenses.accountskuid}
            
            
            

            foreach($user in $users){
                #Write-Host "Wczytanie użytkowników, pierwsz foreach"
                $user_license = $user.licenses | Where-Object {$_.accountskuid -eq $licenses.accountskuid} 
               
                $header =  ($user.firstname+ " " + $user.lastname + " ; " + $user.userprincipalname + " ; " + $licenses.SkuPartNumber) 
                write-host $header
                
                
                
              # Write-Host $header

                foreach  ($license_list in $user_license.servicestatus){
                       # write-host $license_list + " informacje o licencji lista "
                        if($header -ne $null -and $license_list.ServicePlan.ServiceName -eq $Office365_Skype  ){   
                             write-host $header
                            # write-host "check: wyświetlanie użytkowników"
                            #$header = $null
                         }


                      
                       
                        $user_license = "    " + $license_list.ServicePlan.ServiceName + " <--> " + $license_list.ProvisioningStatus

                           # write-host "check: licencje użytkownikow"

                        if($license_list.ProvisioningStatus -notlike "*Disabled*"  ) {
                         #write-host "check: filtry"

                             # if($license_list.ServicePlan.ServiceName -like $Office365_Skype)
                                  write-host $user_license  
                                

                             
                                                

                                            
                                 #     }

                        }
                        }
                        }

                    }
                           
                   
                   


                  
                 
                   
                   
                   
                    
                   
         # $acctSKU="learn:ENTERPRISEPACK"           
    
                    

                

