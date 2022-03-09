*** Settings ***
Documentation  This test suite will validate the Change User Role API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions
*** Keywords ***

Get User Role
    [Arguments]     ${headers}  ${baseStationId}    ${users_name_API}
    Get User Profile API    ${headers}  ${baseStationId}
    Validate Response Code  ${response}  200
    ${res}=  Get Result Response   ${response}
    FOR    ${item}    IN    @{res['Users']}
       ${status}=   Run Keyword and Return Status  Should Be Equal  ${item['name']}     ${users_name_API}
       Run Keyword If   ${status}   Set Test Variable   ${user_role}    ${item['Roles']}
    END
    ${temp}=    Get From Dictionary   ${user_role}[0]   name
    Set Test Variable     ${user_role}      ${temp}

*** Test Cases ***
Change User Role To Admin- 200 OK
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${users_name_API}
    Change Role API   ${headers}    ${userId}   ADMIN
    Validate Response Code & Message    ${response}    200   message  ${Role_Changed_Successfullly}
    Get User Role  ${headers}  ${baseStationId}   ${users_name_API}
    Should Be Equal    ${user_role}       ADMIN

Change User Role To User- 200 OK
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${users_name_API}
    Change Role API   ${headers}    ${userId}   USER
    Validate Response Code & Message    ${response}    200   message  ${Role_Changed_Successfullly}
    Get User Role  ${headers}  ${baseStationId}   ${users_name_API}
    Should Be Equal    ${user_role}     USER

Change User Role- Invalid Role
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${users_name_API}
    Change Role API   ${headers}    ${userId}   User
    Validate Response Code & Message    ${response}    401  error   ${Invalid_Role}


Change User Role- No token provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header
    Change Role API   ${headers}    randomUserId   USER
    Validate Response Code & Message    ${response}    402  error   ${No_Token_Provided}

Change User Role- Require Admin Role
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${user_email_API}  ${user_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${users_name_API}
    Change Role API   ${headers}    ${userId}   USER
    Validate Response Code & Message    ${response}    403   error  ${Require_Admin_Role}

Change User Role- User Got Logged Out
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${users_name_API}
    Logout User API    ${headers}
    Change Role API   ${headers}    ${userId}   USER
    Validate Response Code & Message    ${response}    405   error  ${Unauthorized_Device}

Change User Role- Unauthorized Token
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Change Role API   ${headers}    randomUserId   USER
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}


Change User Role- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Change Role API   ${headers}    ${EMPTY}   USER
    Validate Response Code & Message    ${response}    500   error  ${Internal_Server_Error}