# Active Directory OU and User Creator

This PowerShell script automates the creation of Organizational Units (OUs) in Active Directory and assigns users to these OUs based on a list of names for testing purposes. It also ensures that users are not created if they already exist in Active Directory.

## Prerequisites

Before running this script, ensure you have the following:

- Active Directory domain and admin privileges.
- PowerShell installed on your system.

## Configuration

1. Name your OUs by modifying the `$organizationalUnits` array. Add the names of the OUs where you want to create user accounts.

```powershell
$organizationalUnits = @('Marketing', 'Sales', 'Finance', 'IT', 'HR', 'Legal')
```

2. Specify the desired password for user accounts in the `$password` variable. The password is converted to a secure string.

```powershell
$password = "P@ssw0rd"
$password = ConvertTo-SecureString $password -AsPlainText -Force
```

3. Ensure you have the supplied names.txt file in the same directory.

```powershell
# Name file has 1000 names
$names = Get-Content .\names.txt
```

## Usage

1. Run the script to create OUs and user accounts.

```powershell
.\create_users.ps1
```

## Notes

- The script checks if OUs already exist in Active Directory. If not, it creates them.
- It creates user accounts based on the names in `names.txt`.
- Users are not created if they already exist in Active Directory.

## Disclaimer

Please use this script responsibly and ensure you have proper permissions and backups in place before making any changes to your Active Directory.

---
