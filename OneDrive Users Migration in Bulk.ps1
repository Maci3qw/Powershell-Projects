Import-Module Sharegate
$csvFile = "C:\Temp\OneDrive_All.csv"
$table = Import-Csv $csvFile -Delimiter ","
$PL = "source_admin_URL"
$LD = "destination_admin_URL"

$copysettings = New-CopySettings -OnContentItemExists IncrementalUpdate #Incremental Option 

$source_connection = Connect-Site -Url $PL -Browser -DisableSSO 
$destination_connection = Connect-Site -Url $LD -Browser

#if ($source_connection -eq $null) {
    #Write-Host "Nie można nawiązać połączenia źródłowego. Sprawdź URL lub upewnij się, że masz dostęp."
    #exit

Set-Variable srcSite, dstSite, srcList, dstList
$int = 0
foreach ($row in $table) {
    $int++
    Write-Host "Migrating user no.[$int]"
    Clear-Variable srcSite
    Clear-Variable dstSite
    Clear-Variable srcList
    Clear-Variable dstList
    if ($row.SourceSite -ne $null) {
        $srcSite = Connect-Site -Url $row.SourceSite.Trim() -UseCredentialsFrom $source_connection
        Write-Host "SourceSite: " $sourceSite
        }
    if ($row.DestinationSite -ne $null) {
    $dstSite = Connect-Site -Url $row.DestinationSite.Trim() -UseCredentialsFrom $destination_connection
        Write-Host "SourceSite: " $sourceSite
        }
    $srcList = Get-List -Site $srcSite -Name "Dokumenty"
    $dstList = Get-List -Site $dstSite -Name "Dokumente"
    Copy-Content -SourceList $srcList -DestinationList $dstList -CopySettings $copysettings
    #Remove-SiteCollectionAdministrator -Site $srcSite
    #Remove-SiteCollectionAdministrator -Site $dstSite
}