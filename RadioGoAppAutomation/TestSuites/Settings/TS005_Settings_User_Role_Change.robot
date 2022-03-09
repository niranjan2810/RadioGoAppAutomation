*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
Validate User Role Change from App- Click Ok Button
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    ${user_role}=   Change User Role
    RadioGo User SignOut
    RadioGo User SignIn  ${user_email}  ${user_password}
    Open Settings Screen
    Element Attribute Should Match   ${Locators['settings_user_role']}  text    ${user_role}
    RadioGo User SignOut
    RadioGo User SignIn  ${owner_email}  ${password}
    Open Settings Screen
    ${user_role1}=   Change User Role
    RadioGo User SignOut
    RadioGo User SignIn  ${user_email}  ${user_password}
    Open Settings Screen
    Element Attribute Should Match   ${Locators['settings_user_role']}  text    ${user_role1}
    RadioGo User SignOut
    RadioGo User SignIn  ${owner_email}  ${password}
    Validate Welcome Screen   ${ownerFirstName}

Validate User Role Change from App-Click Cancel Button
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    ${user_role_text1}=    Get Text    ${Locators['setting_user_role_change']}
    Click Text      ${user_role_text1}
    Wait Until Page Contains    You are changing role of other User.If you want to proceed,the other user may get logged off.Do you want to continue ?  timeout=30
    Click Text      NO
    Wait Until Page Contains      Settings    timeout=30












