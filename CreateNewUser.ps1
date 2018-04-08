# +---------------------------------------------------------------------------
# | File : CreateNewUser.ps1                                         
# | Version : 2.10                                         
# | Purpose : Create new user accounts
# | Creator: Ian Martin, Stephen Woods
# | Date: 16/05/2016
# +----------------------------------------------------------------------------

Import-Module ActiveDirectory

#import XAML for GUI
. .\LoadDialog.ps1
. .\Functions.ps1

$AddUsers = Get-ADUser -LDAPFilter '(mail=*)'
foreach ($AddUser in $AddUsers) {
    $WPFManager.Items.Add($AddUser.Name)
}

$WPFSubmit.Add_Click({
    $WPFSubmit.IsEnabled = "false"
    $WPFSubmit.Opacity = "0.5"
    $WPFSubmit.Focusable= "False"
    createUser
    $WPFSubmit.Content = 'Completed!'
})

$WPFBranch.Add_LostFocus({
    switch ($WPFBranch.text) {
        "Allied Health" {
            HideDropDowns
            $WPFSiteLabel1.Visibility = "Visible"
            $WPFAHSite.Visibility = "Visible"
        }
        "Corporate Services" {
            HideDropDowns
            $WPFDeptLabel.Visibility = "Visible"
            $WPFDepartment.Visibility = "Visible"
        }
        "Employment and Training" {
            HideDropDowns
            $WPFMELabel.Visibility = "Visible"
            $WPFMESector.Visibility = "Visible"
        }
        "Fundraising" {
            HideDropDowns
        }
        "Home and Community Services" {
            HideDropDowns
            $WPFHCLabel.Visibility = "Visible"
            $WPFHCRegion.Visibility = "Visible"
        }
    }
})
$WPFHCRegion.Add_LostFocus({
    switch ($WPFHCRegion.text) {
        "CQWB" {
            HideDropDowns
            $WPFHCLabel.Visibility = "Visible"
            $WPFHCRegion.Visibility = "Visible"
            $WPFSiteLabel2.Visibility = "Visible"
            $WPFCQWBSite.Visibility = "Visible"
        }
        "MNMSC" {
            HideDropDowns
            $WPFHCLabel.Visibility = "Visible"
            $WPFHCRegion.Visibility = "Visible"
            $WPFSiteLabel2.Visibility = "Visible"
            $WPFMNMSCSite.Visibility = "Visible"
        }
        "South Coast" {
            HideDropDowns
            $WPFHCLabel.Visibility = "Visible"
            $WPFHCRegion.Visibility = "Visible"
            $WPFSiteLabel2.Visibility = "Visible"
            $WPFSCSite.Visibility = "Visible"
        }
        "South West" {
            HideDropDowns
            $WPFHCLabel.Visibility = "Visible"
            $WPFHCRegion.Visibility = "Visible"
            $WPFSiteLabel2.Visibility = "Visible"
            $WPFSWSite.Visibility = "Visible"
        }
    }
})
$WPFMESector.Add_LostFocus({
    switch ($WPFMESector.text) {
        "Employment" {}
        "Printing" {}
        "Training" {}
    }
})

$Form.ShowDialog() | out-null
       

