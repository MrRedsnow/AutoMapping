foreach ($mbx in Get-Mailbox)
{
	Write-Output -n "Mailbox: " 
	Write-Output -n $mbx.PrimarySmtpAddress
    
	foreach ($mbxsharedwith in Get-MailboxPermission $mbx.PrimarySmtpAddress) 
	{
		if($mbxsharedwith.AccessRights -eq "FullAccess")
			{
			Remove-MailboxPermission -Identity $mbx.PrimarySmtpAddress -User $mbxsharedwith.user -AccessRights FullAccess
			Add-MailboxPermission -Identity $mbx.PrimarySmtpAddress -User $mbxsharedwith.user -AccessRights FullAccess -AutoMapping:$false
		}
	}
	Write-Output --------------------------------------
}