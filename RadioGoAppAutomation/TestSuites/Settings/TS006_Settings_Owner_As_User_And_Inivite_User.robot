*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
Validate Setting Screen for Onwer as User
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Element Attribute Should Match   ${Locators['settings_user_role']}  text    Administrator
    ${firstName}=   Split String    ${ownerFirstName}
    Element Attribute Should Match  ${Locators['settings_user_name']}    text    ${firstName}[0]
    Page Should Contain Element     ${Locators['settings_edit_account']}
    Page Should Contain Element     ${Locators['settings_add_new_user']}
    Page Should Contain Text      FEEDBACK
    Page Should Contain Text    FAQ
    Page Should Contain Text    SIGN OUT FROM THIS DEVICE
    Page Should Contain Text    SIGN OUT FROM ALL MY DEVICES ?

Owner Invites New User
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Click Element  ${Locators['settings_add_new_user']}
    Wait Until Page Contains   Add User     timeout=30s
    Element Attribute Should Match  ${Locators['settings_txt_input_invite_user_email']}     text    Email
    Input Text Keyword  ${Locators['settings_txt_input_invite_user_email']}     ${addUserEmail}
    Click Element   ${Locators['settings_send_invitation']}
    Wait Until Page Contains    Invitation sent successfully!   timeout=10  error=Screen did not found text Invitation sent successfully!
    Click Text  OK
    Wait Until Page Contains    Settings  timeout=30s   error= Settings text not found on the required screen

Invite User with Empty Email
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Click Element  ${Locators['settings_add_new_user']}
    Wait Until Page Contains   Add User     timeout=30s
    Element Attribute Should Match  ${Locators['settings_txt_input_invite_user_email']}     text    Email
    Element Should Be Disabled   ${Locators['settings_send_invitation']}

Invite User with existing Email
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Click Element  ${Locators['settings_add_new_user']}
    Wait Until Page Contains   Add User     timeout=30s
    Element Attribute Should Match  ${Locators['settings_txt_input_invite_user_email']}     text    Email
    Input Text Keyword  ${Locators['settings_txt_input_invite_user_email']}     ${addUserEmail}
    Click Element   ${Locators['settings_send_invitation']}
    Wait Until Page Contains    Email is already in use!    timeout=10      error=Email is already in use! text not found on the screen

Invite User with Invalid Email
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Click Element  ${Locators['settings_add_new_user']}
    Wait Until Page Contains   Add User     timeout=30s
    Element Attribute Should Match  ${Locators['settings_txt_input_invite_user_email']}     text    Email
    Input Text Keyword  ${Locators['settings_txt_input_invite_user_email']}    invalidgamil.com
    Click Element   ${Locators['settings_send_invitation']}
    Wait Until Page Contains    Email address is not valid  timeout=10  error=Email address is not valid text not found on the screen





