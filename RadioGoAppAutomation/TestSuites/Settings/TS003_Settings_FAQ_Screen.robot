*** Settings ***
Documentation  This test suite will validate the FAQ screen
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
Validate FAQ Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text      FAQ
    Wait Until Page Contains    FAQ     timeout=10
    Validate RadiGo Logo on Header
    Wait Until Page Contains Element    ${Locators['settings_faq_list']}    timeout=10  error=Unable to find FAQ list on the screen
    Click Element       ${Locators['settings_faq_expand_grp']}
    Wait Until Page Contains Element    ${Locators['settings_faq_expand_child']}  timeout=10  error=Unable to expand the FAQ test

#Validate the Help on FAQ Screen
#    [Documentation]  Help screen is under developement

Back Button on FAQ Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Click Text   FAQ
    Wait Until Page Contains    FAQ     timeout=10
    Click Element   ${Locators['img_back_btn']}
    Wait Until Page Contains    Settings    timeout=30
