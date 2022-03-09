*** Settings ***
Resource          ../../Utilities/Library.robot
Suite Setup     RadioGo Suite Setup
Test Setup      RadioGo Test Setup
Test Teardown   Quit Application
Suite Teardown  Close application

*** Keywords ***
Validate List of User
    [Documentation]  This is the keyword to Swipe down on screen
    [Arguments]  ${text}
     FOR    ${i}    IN RANGE    0    15
       # Swipe    15    600    15    200
        ${status}=    Run Keyword And Return Status  Page Should Contain Text    ${text}
        Run Keyword If    ${status}     Exit For Loop
        Swipe     300   800    300   400
        ${status}=    Run Keyword And Return Status  Page Should Contain Text    ${text}
        log    ${status}
        Run Keyword If    ${status}     Exit For Loop
        ${i}    Set Variable    ${i}+1
    END

Invite User
    [Arguments]  ${email}
    Click Element  ${Locators['settings_add_new_user']}
    Wait Until Page Contains   Add User     timeout=30s
    Input Text Keyword  ${Locators['settings_txt_input_invite_user_email']}     ${email}
    Click Element   ${Locators['settings_send_invitation']}
    Wait Until Page Contains    Invitation sent successfully!   timeout=10  error=Screen did not found text Invitation sent successfully!
    Click Text  OK
    Wait Until Page Contains    Settings  timeout=30s   error= Settings text not found on the required screen

*** Test Cases ***
Validate User List on Settings Screen for Owner As User
    [Tags]  Settings  AppRegression
    Get Access Token & BaseStationId   ${owner_email}  ${password}
    Create Header   access-token    ${token}
    Get User Profile API    ${headers}   ${baseStationId}
    Validate Response Code  ${response}  200
    ${res}=  Get Result Response   ${response}
    @{name}=    Create List
    @{email}=   Create List
    FOR    ${node}    IN    @{res['Users']}
       ${status}=  Run Keyword And Return Status   Should Be Equal    '${node['isActive']}'   'False'
        Run Keyword If   ${node['isActive']}  Append To List   ${name}     ${node['name']}
        Run Keyword If   ${status}  Append To List   ${email}     ${node['email']}
    END
    Log List    ${name}
    Log List    ${email}
    @{first_name}=    Create List
    FOR     ${item}   IN   @{name}
        #log to console  ${item}
        @{temp}  Split String    ${item}
        Append to List  ${first_name}   ${temp}[0]
    END
    Log List    ${first_name}
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    FOR     ${item}   IN   @{email}
        Validate List of User     ${item}
    END
    FOR     ${item}   IN   @{first_name}
        Validate List of User     ${item}
    END

Validate User List on Settings Screen for Non-Admin User
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    RadioGo User SignOut
    RadioGo User SignIn    ${user_email}    ${user_password}
    Validate Welcome Screen    ${users_name}
    Open Settings Screen
    Element Attribute Should Match  ${Locators['settings_user_role']}   text    User
    Page Should Contain Text    Other Users
    RadioGo User SignOut
    RadioGo User SignIn   ${owner_email}    ${password}
    Validate Welcome Screen     ${ownerFirstName}

Validate User List on Settings Screen for Admin User
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    ${user_role}=   Change User Role
    RadioGo User SignOut
    RadioGo User SignIn  ${user_email}  ${user_password}
    Open Settings Screen
    Element Attribute Should Match  ${Locators['settings_user_role']}   text     ${user_role}
    ${firstName}=   Split String    ${ownerFirstName}
    Page Should Contain Text    ${firstName}[0]
    @{webElements}  Get Webelements     ${Locators['settings_delete_button']}
    ${count}=   Get Length      ${webElements}
    Get Access Token & BaseStationId   ${user_email}    ${user_password}
    Create Header   access-token    ${token}
    Get User Profile API    ${headers}   ${baseStationId}
    Validate Response Code  ${response}  200
    ${res}=  Get Result Response   ${response}
    @{userID}=    Create List
     FOR    ${node}    IN    @{res['Users']}
         Append To List   ${userID}     ${node['userId']}
    END
    Log List   ${userID}
    ${user_count}=   Get Length      ${userID}
    Should Be Equal As Numbers    ${count}      ${user_count-2}
    RadioGo User SignOut
    RadioGo User SignIn  ${owner_email}     ${password}
    Validate Welcome Screen    ${ownerFirstName}
    Open Settings Screen
    ${user_role}=   Change User Role
    Should Match    ${user_role}    User


Delete User-as Owner
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    Invite User     kshyp.ujala@gmail.com
    @{webElements}  Get Webelements     ${Locators['settings_delete_button']}
    log list    ${webElements}
    Click Element  ${webElements}[1]
    Wait Until Page Contains   User deleted     timeout=30s     error=Unable to capture message.Check screenshot


Delete User As Admin User
    [Tags]  Settings  AppRegression
    Validate Welcome Screen   ${ownerFirstName}
    Open Settings Screen
    ${user_role}=   Change User Role
    RadioGo User SignOut
    RadioGo User SignIn     ${user_email}   ${user_password}
    Validate Welcome Screen     ${users_name}
    Open Settings Screen
    Invite User     kshyp.ujala@gmail.com
    @{webElements}  Get Webelements     ${Locators['settings_delete_button']}
    log list    ${webElements}
    Click Element  ${webElements}[0]
    Wait Until Page Contains   User deleted     timeout=30s     error=Unable to capture message.Check screenshot
    RadioGo User SignOut
    RadioGo User SignIn  ${owner_email}     ${password}
    Validate Welcome Screen    ${ownerFirstName}
    Open Settings Screen
    ${user_role}=   Change User Role
    Should Match    ${user_role}    User

