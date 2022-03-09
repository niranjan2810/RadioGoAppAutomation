*** Settings ***
Documentation  This test suite will validate the FeedBack screen
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Test Cases ***
Validate Feedback Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen  ${ownerFirstName}
    Open Settings Screen
    Click Text      FEEDBACK
    Wait Until Page Contains    Feedback     timeout=10
    Validate RadiGo Logo on Header
    Element Attribute Should Match  ${Locators['settings_feedback_RateRadioGo_text']}    text    Rate RadioGo
    Page Should Contain Element     ${Locators['settings_feedback_overall_performance']}
    Page Should Contain Text    Overall Performance
    Page Should Contain Element     ${Locators['settings_feedback_radio_quality']}
    Page Should Contain Text    Radio Quality
    Page Should Contain Element     	${Locators['settings_feedback_app_experience']}
    Page Should Contain Text    App Experience
    Swipe    80    417    517    414
    Swipe    532    655    525    659
    Swipe    486    889    57    869
    Capture Page Screenshot
    Element Attribute Should Match  ${Locators['settings_feedback_optional_text']}  text    (OPTIONAL)
    Input Text  ${Locators['settings_feedback_text_area']}   Test feedback
    Page Should Not Contain Element     ${Locators['settings_feedback_optional_text']}
    Click Text  	SUBMIT FEEDBACK
    Wait Until Page Contains    Feedback created successfully.  timeout=30
    Click Text  OK
    Wait Until Page Contains    Settings    timeout=30

#Validate the Help on Feedback Screen
#    [Documentation]  Help screen is under developement

Back Button on Feedback Screen
    [Tags]  Settings  AppRegression
    Validate Welcome Screen     ${ownerFirstName}
    Open Settings Screen
    Click Text   FEEDBACK
    Wait Until Page Contains    Feedback     timeout=10
    Click Element   ${Locators['img_back_btn']}
    Wait Until Page Contains    Settings    timeout=30
