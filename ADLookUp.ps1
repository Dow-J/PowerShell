import-module activedirectory
$Matches = @()
Import-csv -Path C:\scripts\testcsv2.csv | 
% { 
    $ADUser = get-aduser -Filter "UserPrincipalName -eq '$($_.InternetAddress)'" -Properties * 
    
    if ($_.InternetAddress -eq $ADUser.userprincipalname) {
        $Matches += [PSCustomObject]@{
            Userprincipalname = $ADUser.userprincipalname
            #you can add more column headers if you want
        }
    }
    $Matches | Export-Csv -Path "matches.csv" -NoTypeInformation
}   