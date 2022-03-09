*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Keywords ***
Update User Name
    [Documentation]  This keyword will update username
    [Arguments]  ${updateName}
    Input Text Keyword  ${Locators['settings_edit_profile_enter_username']}   ${updateName}
    Element Attribute Should Match     ${Locators['settings_edit_profile_enter_username']}  text   ${updateName}
    Click Text  SUBMIT

Open Edit Profile Screen
    [Documentation]  This keyword will open edit profile screen!
    Click Element   ${Locators['settings_edit_button_img']}
    Wait Until Page Contains    Edit Profile    timeout=10

Open Change Password Screen
    Click Text   CHANGE YOUR PASSWORD
    Wait Until Page Contains    Change Password     timeout=30

Input Text to Change Password Fields
    [Arguments]  ${oldPassword}      ${newPassword}      ${confirmPassword}
    Input Text Keyword  ${Locators['change_password_old']}  ${oldPassword}
    Input Text Keyword  ${Locators['change_password_new']}  ${newPassword}
    Input Text Keyword  ${Locators['change_password_confirm']}  ${confirmPassword}
    Click Text  SUBMIT

*** Test Cases ***

Validate Edit Profile Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Validate RadiGo Logo on Header
    Element Attribute Should Match     ${Locators['settings_edit_profile_enter_username']}  text   ${ownerFirstName}
    Page Should Contain Text    SUBMIT
    Page Should Contain Text    CHANGE YOUR PASSWORD
    Page Should Contain Element     ${Locators['settings_edit_profile_arrow_img']}

Validate Update User Name with Same Name as Current Name
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Click Text  SUBMIT
    Wait Until Page Contains    Username is the same as before.    timeout=10

Validate Update Username with Empty UserName
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Clear Text  ${Locators['settings_edit_profile_enter_username']}
    Click Text  SUBMIT
   Element Should Be Disabled     ${Locators['submit_button']}   timeout=10

Validate Update User Name with New Name
    [Tags]  Settings  AppRegression
    Validate Welcome Screen      ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Update User Name  Updated Name
    Wait Until Page Contains    Name changed successfully!  timeout=10
    Click Element   ${Locators['img_back_btn']}
    Wait Until Page Contains    Settings    timeout=30
    Element Attribute Should Match  ${Locators['settings_user_name']}    text    Updated
    Quit Application
    Launch Application
    Validate Welcome Screen     Updated Name
    Open Settings Screen
    Open Edit Profile Screen
    Update User Name  ${ownerFirstName}
    Wait Until Page Contains    Name changed successfully!  timeout=10
    Click Element   ${Locators['img_back_btn']}
    Wait Until Page Contains    Settings    timeout=30
    ${firstName}=   Split String    ${ownerFirstName}
    Element Attribute Should Match  ${Locators['settings_user_name']}    text    ${firstName}[0]

#Validate Help on Edit User Screen

Validate Change Password Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Validate RadiGo Logo on Header
    Page Should Contain Element     ${Locators['change_password_icon']}
    Page Should Contain Element     ${Locators['change_password_old']}
    Page Should Contain Element     ${Locators['change_password_new']}
    Page Should Contain Element     ${Locators['change_password_confirm']}

Validate Change Password with Invalid Old Password
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Input Text to Change Password Fields  invalid123    newRadio123    newRadio123
    Wait Until Page Contains    Invalid old Password!   timeout=30

Validate Change Password with different New and Confirm Password
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Input Text to Change Password Fields  ${password}   newRadio123    newRadio12
    Wait Until Page Contains    Password and confirm password are not matching  timeout=30

Validate Cancel Button on Change Password Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Click Text   CANCEL
    Wait Until Page Contains    Edit Profile    timeout=15

Validate Back Button on Change Password Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Click Element   ${Locators['img_back_btn']}
    Wait Until Page Contains    Edit Profile    timeout=15

#Validate Help on Change Password Screen

Validate Change Password With one of the field Empty
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Input Text to Change Password Fields  ${password}   ${EMPTY}    newRadio12
    Element Should Be Disabled     ${Locators['submit_button']}   timeout=10

Validate Change Password length less than 8 characters
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Input Text to Change Password Fields  ${password}   12345    newRadio12
    Wait Until Page Contains    Password is to short enter atleast 8 characters.  timeout=30

Validate Change Password With Valid Old and New Password
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Input Text to Change Password Fields  ${password}   ${newPassword}    ${newPassword}
    Wait Until Page Contains    Your password has been  timeout=10
    Wait Until Page Contains    Successfully updated.   timeout=10
    Click Text  OK
    RadioGo User SignIn    ${owner_email}   ${newPassword}
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Open Edit Profile Screen
    Open Change Password Screen
    Input Text to Change Password Fields  ${newPassword}   ${password}    ${password}
    Wait Until Page Contains    Your password has been     timeout=10
    Wait Until Page Contains    Successfully updated.   timeout=10
    Click Text  OK
    RadioGo User SignIn    ${owner_email}   ${password}
    Validate Welcome Screen  ${ownerFirstName}























