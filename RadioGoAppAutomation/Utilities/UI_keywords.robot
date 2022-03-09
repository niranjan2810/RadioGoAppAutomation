*** Keywords ***

Get Appium Server URL
    [Documentation]  This is the keyword to get appium srever URL
    ${remote_url}    set variable    http://${appium_hostname}:${appium_portNumber}/wd/hub
    [Return]    ${remote_url}

Open iOS RadioGo App
    [Documentation]  This keyword will launch RadioGo Application on iOS  platform
    ${url}=    Get Appium Server URL
    Open Application    ${url}   platformName=iOS   platformVersion=${ios_platform_version}    deviceName=${ios_device_name}   automationName=XCUITest
    ... app=${ios_app_location}     noReset=true    launchTimeout=100000

#bundleId='com.anywhere.radiogo'
#app=${ios_app_location}

Open Android RadioGo App
    [Documentation]  This keyword will launch RadioGo Application on Android platform
    ${url}=    Get Appium Server URL
    Open Application    ${url}    platformName=android    deviceName=${android_device_name}     appPackage=${appPackage}
    ...     appActivity=${appActivity}    noReset=true        newCommandTimeout=100000
    ...     skipServerInstallation=false

Open RadioGo Application
    [Documentation]  This is the keyword to open RadioGo Application and keep test running
    [Arguments]    ${appPackage}    ${appActivity}
    ${device_platform}=    Get Environment Variable   device_platform   default=ios
    Run Keyword If  '${device_platform}' == 'ios'   Open iOS RadioGo App
    ...     ELSE IF  '${device_platform}' == 'android'  Open Android RadioGo App
     ...    ELSE    run keyword  FAIL    Device platform yet not supported with Automation or Please Spell Check
    Sleep   5

Launch Radio Go Application
    [Documentation]  This is the keyword to launch RadioGo Application and keep test running
    ${device_platform}=    Get Environment Variable   device_platform   default=ios
    Run Keyword If  '${device_platform}' == 'ios'   Launch iOS RadioGo App
    ...     ELSE IF  '${device_platform}' == 'android'  Launch Android RadioGo App
     ...    ELSE    run keyword  FAIL    Device platform yet not supported with Automation or Please Spell Check
    Sleep   5

Launch iOS RadioGo App
    [Documentation]  This is the keyword to launch RadioGo Application on iOS  platform and keep test running
    Launch Application
    #Give Permissions to RadioGo Application

Launch Android RadioGo App
    [Documentation]  This is the keyword to launch RadioGo Application on Android platform and keep test running
    Launch Application

Set Locator
    [Documentation]  This is the keyword to set locators as global parameter
    ${device_platform}=    Get Environment Variable   device_platform
    log     ${device_platform}
    ${locators}=    Run Keyword If    '${device_platform}' == 'android'    Load JSON From File    config/Locators/android_locators.json
    ...    ELSE IF    '${device_platform}' == 'ios'    Load JSON From File    config/Locators/ios_locators.json
    ...    ELSE    run keyword  FAIL     Device platform yet not supported with Automation or Please Spell Check
    Set Global Variable    ${Locators}      ${locators}

Give Permissions to RadioGo Application
    [Documentation]  This is the keyword will give required permissions to the RadioGo app
    ${device_platform}=    Get Environment Variable   device_platform   default=ios
    Run Keyword If  '${device_platform}' == 'ios'         Give Permissions to iOS RadioGo App
    ...     ELSE IF  '${device_platform}' == 'android'    Give Permissions to Android RadioGo App
     ...    ELSE    run keyword  FAIL    Device platform yet not supported with Automation or Please Spell Check

Give Permissions to iOS RadioGo Application
    [Documentation]  This is the keyword for getting required permissions on iOS platform
    Wait Until Page Contains    "RadioGo” Would Like to Send You Notifications
    Click Element   ${Locators['AllowNotifications']}

Give Permissions to Android RadioGo App
    [Documentation]  This is the keyword for getting required permissions on iOS platform
    ${status}=    Run Keyword And Return Status  Wait Until Page Contains    Allow only while using the app
    Run Keyword If    ${status}    Click Text      	Allow only while using the app
    sleep   3s
#    Click Text      Allow
    Click Element    id=com.android.permissioncontroller:id/permission_allow_button
#    Page Should Contain Text    Permissions granted.    loglevel=INFO
    Sleep  3s


Input Text Keyword
    [Documentation]  This keyword with input text in required field and then will hide the keyboard
    [Arguments]     ${locators}     ${value}
    Input text      ${locators}  ${value}
    Hide Keyboard

#Validate RadioGo User SignIn Screen
#    Wait Until Page Contains    Welcome to  timeout=30
#    Wait Until Page Contains    ${Locators['enter_email_id']}   timeout=30s

Validate Launch Screen
    [Documentation]  This keyword validate if three elements are present on Launch screen - 1. 'Already Have An Account' 2/3. 'I'm New RadioGo User/Owner'
    wait until page contains element    ${Locators['already_have_account']}
    page should contain element         ${Locators['new_radio_go_owner']}
    page should contain element         ${Locators['new_radio_go_user']}
#    page should contain element         ${Locators['already_have_account']}

Open Sign In Screen
    [Documentation]  This keyword is to open Sign In screen
    click element       ${Locators['already_have_account']}

Validate Sign In Screen
    [Documentation]  This keyword validate if three elements are present on Sign In screen  - 1. Email 2. Password 3. Sign In
    Wait Until Page Contains Element    ${Locators['enter_email_id']}
    #page should contain element         ${Locators['enter_email_id']}
    page should contain element         ${Locators['enter_password']}
    page should contain element         ${Locators['signin_button']}

RadioGo User SignIn
    [Documentation]  User SignIn Keyword
    [Arguments]     ${email}        ${password}
    Wait Until Page Contains    ${Locators['enter_email_id']}   timeout=30s
    Input Text Keyword    ${Locators['enter_email_id']}   ${email}
    Input Text Keyword    ${Locators['enter_password']}    ${password}
    Click Element   ${Locators['signin_button']}
#    ${status}=   Run Keyword And Return Status    Wait Until Page Contains    Welcome,    timeout=30
#    Run Keyword If  ${status}    Log     User SignIn was successful
#    ...  ELSE   Fail     User SignIn Failed

Validate Welcome Screen
    [Arguments]     ${username}
    [Documentation]  This keyword will validate the welcome screen of the application. Takes one argument which is first name of signed in user
     ${status}=     Run Keyword And Return Status   Wait Until Page Contains    ${username}   timeout=30
     Run Keyword If     ${status}   Log     Welcome Page contains username ${username}!
     ...  ELSE  FAIL    Fail to launch welcome screen!

RadioGo User SignOut
    [Documentation]  This keyword will make user signed out of the application
    Wait Until Page Contains    Settings    timeout=30
    Click Text      SIGN OUT FROM THIS DEVICE
    Wait Until Page Contains    YES     timeout=30
    Click Text      YES
    ${status}=  Run Keyword And Return Status   Wait Until Page Contains    Logged out successfully!    timeout=30s
    Run Keyword If  ${status}    Log   User Logged out Successfully!
    ...  ELSE   Fail    User did not logged out!
    Wait Until Page Contains Element    ${Locators['enter_email_id']}   timeout=30

Open Settings Screen
    [Documentation]  This keyword will launch the setting screen for the signed-in user
    Wait Until Page Contains      MANAGE YOUR ACCOUNT  timeout=30s
    Click Text  MANAGE YOUR ACCOUNT
    Wait Until Page Contains  Settings  timeout=30s

Validate RadiGo Logo on Header
    [Documentation]    This keyqord will validate the RadioGo Logo on the Header of each screen
    Wait Until Page Contains Element    ${Locators['radio_go_logo']}    timeout=10     error=Unable to find RadioGo Logo on the header

Change User Role
    ${user_role_text1}=    Get Text    ${Locators['setting_user_role_change']}
    Click Text      ${user_role_text1}
    Wait Until Page Contains    You are changing role of other User.If you want to proceed,the other user may get logged off.Do you want to continue ?  timeout=30
    Click Text      YES
    Wait Until Page Contains   Role changed successfully!  timeout=30
    ${user_role_text2}=     Get Text    ${Locators['setting_user_role_change']}
    Should Not Be Equal As Strings  ${user_role_text1}  ${user_role_text2}
    ${status}=  Run Keyword and Return Status   Should Match     SET AS ADMINISTRATOR    ${user_role_text2}
    Run Keyword IF  ${status}   Set Suite Variable  ${user_role}   User
    ...  ELSE   Set Suite Variable  ${user_role}   Administrator
    [Return]    ${user_role}

Validate Save It Screen
    wait until page contains element    ${Locators['BottomSaveIt']}
    click element   ${Locators['BottomSaveIt']}
    wait until page contains element    ${Locators['SaveItPageTitle']}      timeout=10
    page should contain element    ${Locators['SaveItPageTitle']}      timeout=10
    page should contain element    ${Locators['AddSaveIt']}      timeout=10
    page should contain element    ${Locators['ScheduleTab']}      timeout=10
    page should contain element    ${Locators['DownloadTab']}      timeout=10
    page should contain element    ${Locators['PlayTab']}      timeout=10

Validate Add Save It Screen
    Validate Save It Screen
    Click Element                  ${Locators['AddSaveIt']}
    wait until page contains element    ${Locators['AddSaveItPageTitle']}      timeout=10
    page should contain element    ${Locators['AddSaveItPageTitle']}      timeout=10
    page should contain element    ${Locators['ChoosePresetTitle']}      timeout=10
    page should contain element    ${Locators['CloseScheduleSaveIt']}      timeout=10
    scroll down                    ${Locators['ScheduleSaveIt']}
    page should contain element    ${Locators['StartDateTitle']}      timeout=10
    page should contain element    ${Locators['DurationTitle']}      timeout=10
    page should contain element    ${Locators['ScheduleSaveIt']}      timeout=10
    page should contain element    ${Locators['CancelScheduleSaveIt']}      timeout=10






