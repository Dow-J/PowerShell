import-module activedirectory # import ad powershell module
$hash = @{}; # create empty hash table
$users = Get-ADUser -Filter { Enabled -eq $true } -Properties Mail # Gets AD Users that are enabled and stores the value of their mail attribute
$users | ForEach-Object { if($_.Mail) { $hash[$_.Mail] += 1 } } # Go through all filtered users and, if mail attribute is not null, tally each occurance of mail attribute
$filteredUsers = $users | Where-Object { if($_.Mail) { $hash[$_.Mail] -gt 1 } } # Gets all users with a tally greater than 1
$filteredUsers | Select-Object -Property SamAccountName, Mail | Export-Csv -Path "MailDup.csv" -NoTypeInformation