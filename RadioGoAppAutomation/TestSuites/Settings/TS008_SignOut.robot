*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
Logout User- Click Yes
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text      SIGN OUT FROM THIS DEVICE
    Wait Until Page Contains    Are you sure you want to Sign out ?     timeout=30
    Click Text      YES
    Wait Until Page Contains    Logged out successfully!    timeout=30  error=Some error occurred
    Validate Sign In Screen
    RadioGo User SignIn  ${owner_email}    ${password}
    Validate Welcome Screen   ${ownerFirstName}

Logout User- Click No
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text      SIGN OUT FROM THIS DEVICE
    Wait Until Page Contains    Are you sure you want to Sign out ?     timeout=30
    Click Text      NO
    Page Should Contain Text   Settings

Logout All Users- Click Yes
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text      SIGN OUT FROM ALL MY DEVICES ?
    Wait Until Page Contains    Are you sure you want to Sign out ?      timeout=30
    Click Text      YES
    Wait Until Page Contains    Logged out from all devices!   timeout=30  error=Some error occurred
    Validate Sign In Screen
    RadioGo User SignIn  ${owner_email}    ${password}
    Validate Welcome Screen   ${ownerFirstName}

Logout All Users- Click No
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text      SIGN OUT FROM ALL MY DEVICES ?
    Wait Until Page Contains    Are you sure you want to Sign out ?     timeout=30
    Click Text      NO
    Page Should Contain Text   Settings