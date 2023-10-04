# Name your OUs here
$organizationalUnits = @('Marketing', 'Sales', 'Finance', 'IT', 'HR', 'Legal')

# Enter desired password
$password = "P@ssw0rd"
$password = ConvertTo-SecureString $password -AsPlainText -Force

# File with names
$names = Get-Content .\names.txt

# Number of users to put into each OU
[int]$numOfUsersPerOU = $names.Length / $organizationalUnits.Length

Write-Host "Creating OUs"
Write-Host "Finished creating OUs" -ForegroundColor Green
Write-Host

# Create OUs if they don't exist
foreach ($ou in $organizationalUnits) {
    if((Get-ADOrganizationalUnit -Filter {Name -eq $ou}) -eq $null) {
        New-ADOrganizationalUnit -Name $ou -ProtectedFromAccidentalDeletion $false
    }
}

Write-Host "Creating Users"
Write-Host

$j=0
$i=0

# Create Users
foreach($name in $names) {
    $first = $name.Split(" ")[0].ToLower()
    $last = $name.Split(" ")[1].ToLower()
    $username = "$($first[0])$($last)".ToLower()

    # Check if the user exists
    $userExists = Get-ADUser -Filter {SamAccountName -eq $username}

    if (-not $userExists) {
        New-AdUser -AccountPassword $password `
                        -GivenName $first `
                        -Surname $last `
                        -DisplayName $username `
                        -Name $username `
                        -EmployeeID $username `
                        -PasswordNeverExpires $true `
                        -Path "OU=$($organizationalUnits[$j]),$(([ADSI]`"").distinguishedName)" `
                        -Enabled $true
    }

    $i++

    

    # Increment to new OU once number of users per OU is reached
    if ($i -eq $numOfUsersPerOU) {

        # Makure sure we don't go out of index
        if ($j -ge 0 -and $j -lt $organizationalUnits.Length - 1) {
            $j++
            $i=0
        } else {
            Write-Host "Finished creating users" -ForegroundColor Green
            break
        } 
    }         
}
