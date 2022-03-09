*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
Validate Launch of Settings Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Validate RadiGo Logo on Header
    
Launch Settings from My Radio
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Click Text  START USING YOUR RADIO
    Wait Until Page Contains    Settings    timeout=30s
    Click Text  Settings
    Wait Until Page Contains  Settings  timeout=30s

Switch to My Radio Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text  My Radio
    Wait Until Page Contains  My Radio  timeout=30s

Switch to My Tune Preset Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text  Tune Presets
    Wait Until Page Contains  My Radio  timeout=30  error= Unable to load Tune Preset Screen
    Quit Application

Switch to My Save-its Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Click Text  Save-its
    Wait Until Page Contains  Save-its  timeout=30s

#Validate Help on Setting Screen



