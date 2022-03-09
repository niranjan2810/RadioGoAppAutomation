*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
Verify Sign In Screen Elements
    Validate Launch Screen
    Open Sign In Screen
    Validate Sign In Screen

Verify Sign In with Empty Email Field
    Validate Launch Screen
    Open Sign In Screen
    Validate Sign In Screen
    Input Text Keyword    ${Locators['enter_password']}    ${password}
    element should be disabled   ${Locators['signin_button']}

Verify Sign In with Empty Password
    Validate Launch Screen
    Open Sign In Screen
    Validate Sign In Screen
    Input Text Keyword    ${Locators['enter_email_id']}   ${owner_email}
    element should be disabled   ${Locators['signin_button']}

Verify Sign In with Invalid Email
    Validate Launch Screen
    Open Sign In Screen
    Validate Sign In Screen
    RadioGo User SignIn      test@gslab.commm       ${password}
    Wait Until Page Contains    Unauthorized email id!      timeout=30
    Page Should Contain Text    Unauthorized email id!

Verify Sign In with Invalid Password
    Validate Launch Screen
    Open Sign In Screen
    Validate Sign In Screen
    RadioGo User SignIn     ${owner_email}      utterbatty4
    Wait Until Page Contains    Invalid Password!   timeout=30
    page should contain text    Invalid Password!

Verify Password length less than 8 characters
    Validate Launch Screen
    Open Sign In Screen
    Validate Sign In Screen
    RadioGo User SignIn        ${owner_email}      abc
    Wait Until Page Contains    Invalid Password!    timeout=30
    page should contain text    Invalid Password!

Verify Sign In using valid Email & Password
    Validate Launch Screen
    Open Sign In Screen
    Validate Sign In Screen
    RadioGo User SignIn     ${owner_email}    ${password}
    Validate Welcome Screen      ${ownerFirstName}
