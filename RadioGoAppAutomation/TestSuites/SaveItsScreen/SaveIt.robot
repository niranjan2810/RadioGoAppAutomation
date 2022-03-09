*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
TC01 - Validate Elements on Save It page
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Validate Save It Screen

TC 02 - Validate Elements on Add Save It page
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Validate Add Save It Screen

TC 03 - Duration of Save if empty
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Validate Add Save It Screen
    click element   ${Locators['ScheduleSaveIt']}
    wait until page contains    Duration field is empty
    page should contain text    Duration field is empty

TC 04 - Duration of Save It is more than 300
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Validate Add Save It Screen
    Input Text Keyword    ${Locators['DurationField']}    301
    click element   ${Locators['ScheduleSaveIt']}
    wait until page contains    Recording duration must be between 0-300 min
    page should contain text    Recording duration must be between 0-300 min

TC 05 - Duration of Save It is 0
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Validate Add Save It Screen
    Input Text Keyword    ${Locators['DurationField']}    0
    click element   ${Locators['ScheduleSaveIt']}
    wait until page contains    Recording duration must be between 0-300 min
    page should contain text    Recording duration must be between 0-300 min

TC 06 - Add Current time Save It
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Validate Add Save It Screen
    Input Text Keyword    ${Locators['DurationField']}    0
    click element   ${Locators['ScheduleSaveIt']}
    wait until page contains    Your Save-It has been scheduled
    page should contain text    Your Save-It has been scheduled

TC 07 - Add Future time Save It

    click element   "//XCUIElementTypeStaticText[@name=\"Friday, Dec 18, 2020\"]"

