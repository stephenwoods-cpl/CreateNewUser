function createUser {
    #Define variables
    $Server = (Get-ADDomainController).name + "." + (Get-ADDomainController).forest
    $Company = "Choice, Passion, Life"
    $Country = "AU"
    $UserOU = "OU=Test-Removal,OU=Staff,DC=cplqld,DC=org,DC=au"
    $WebPage = "www.cpl.org.au"
    $Groups = @()
    $Deparment = $WPFDept.text
    $FirstN = $WPFfName.text
    $LastN = $WPFlName.text
    $Title = $WPFTitle.text
    $Manager = $WPFManager.text
    $Email = "$FirstN.$LastN@dealersolutions.com.au"
    $Mobile = $WPFMobile.text
    $State = $WPFState.text
    $Password = $WPFPassword.password
    $PhotoPath = "V:\Common\Company Photo Library\Staff Photos\$firstn $lastn"

    #Get manager
    $manager = (Get-ADUser -filter 'Name -like $Manager -OR SAMAccountName -like $manager').SAMAccountName
    ##Swtiches
    . .\Switches.ps1

    #Create the user account
    $user = New-ADUser `
        -Name "$FirstN $LastN" `
        -AccountPassword ($Password | ConvertTo-SecureString -AsPlainText -Force) `
        -GivenName $FirstN `
        -Surname $LastN `
        -DisplayName "$FirstN $LastN" `
        -UserPrincipalName "$FirstN.$LastN@dealersolutions.com.au" `
        -SamAccountName "$FirstN.$LastN" `
        -Title $Title `
        -Department $Deparment `
        -Manager $Manager `
        -Office $Office `
        -OfficePhone $OfficePhone `
        -EmailAddress $Email `
        -Description $Title `
        -Company $Company `
        -Fax $Fax `
        -StreetAddress $Address `
        -City $City `
        -State $State `
        -PostalCode $Post `
        -MobilePhone $Mobile `
        -HomePage $WebPage `
        -Country $Country `
        -Path $UserOU `
        -Enabled $true `
        -Server $Server `
        -PassThru

    #Add user groups
    if ($WPFManager.ischecked) {
        $Groups += "All Managers & Leaders"
    }
    foreach ($Group in $Groups) {
        Add-ADGroupMember -Identity $group -Members $user.SamAccountName -Server $Server
    }
    #Create Required file Structure
    if (!$PhotoPath) {
        New-Item !$PhotoPath -type directory
    }

    #Create word document with details
    $Word = New-Object -ComObject Word.Application
    $Word.Visible = $False
    $Document = $Word.Documents.Add()
    $Selection = $Word.Selection
    $Selection.Font.Size = 16
    $Selection.TypeParagraph()
    $Selection.TypeText("Usersname: $FirstN.$LastN")
    $Selection.TypeParagraph()
    $Selection.TypeText("Password: $Password")
    $Selection.TypeParagraph()
    $Selection.TypeText("Email: $Email")
    $Selection.TypeParagraph()
    $Selection.TypeText("Mobile: $Mobile")
    $Save = "$env:USERPROFILE\desktop\$FirstN Details"
    $Document.SaveAs([ref]$Save,[ref]$SaveFormat::wdFormatDocument)
    $word.Quit()
}

function HideDropDowns {
    $WPFSiteLabel1.Visibility = "Hidden"
    $WPFSiteLabel2.Visibility = "Hidden"
    $WPFDeptLabel.Visibility = "Hidden"
    $WPFAHSite.Visibility = "Hidden"
    $WPFHCLabel.Visibility = "Hidden"
    $WPFHCRegion.Visibility = "Hidden"
    $WPFCQWBSite.Visibility = "Hidden"
    $WPFMNMSCSite.Visibility = "Hidden"
    $WPFMESector.Visibility = "Hidden"
    $WPFMESite.Visibility = "Hidden"
    $WPFDepartment.Visibility = "Hidden"
}