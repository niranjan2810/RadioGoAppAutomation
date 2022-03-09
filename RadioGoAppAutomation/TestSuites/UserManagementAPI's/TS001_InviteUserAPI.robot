*** Settings ***
Documentation  This test suite will validate the Invite User API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions


*** Test Cases ***
Invite User- No token provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Add/Invite User API    ${headers}    ${invite_username_API}   ${invite_user_email_API}  95adf270-f72f-11ea-80f5-4993ab3148c1
    Validate Response Code & Message   ${response}  402     error      ${No_Token_Provided}

Invite User- Require Admin Role
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${user_email_API}    ${user_password_API}
    Create Header   access-token    ${token}
    Add/Invite User API    ${headers}    ${invite_username_API}   ${invite_user_email_API}    ${baseStationId}
    Validate Response Code & Message   ${response}      403     error      ${Require_Admin_Role}

Invite User- Unauthorized Base Station Id
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Add/Invite User API    ${headers}    ${invite_username_API}   ${invite_user_email_API}  ${unauthorizedBaseStationId}
    Validate Response Code & Message   ${response}  403     error     ${Unauthorized_BaseStation}

Invite User- User Got Logged Out
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Add/Invite User API    ${headers}    ${invite_username_API}   ${invite_user_email_API}  ${baseStationId}
    Validate Response Code & Message  ${response}  405  error      ${Unauthorized_Device}

Invite User- Unauthorized Token
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Add/Invite User API    ${headers}    ${invite_username_API}   ${invite_user_email_API}  ${baseStationId}
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Invite User- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Add/Invite User API    ${headers}    ${invite_username_API}   ${EMPTY}  ${baseStationId}
    Validate Response Code & Message  ${response}  500  error      ${Internal_Server_Error}

Add/Invite User- 200 OK
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Add/Invite User API    ${headers}    ${invite_username_API}   ${invite_user_email_API}  ${baseStationId}
    Validate Response Code & Message   ${response}  200     message     ${Invitation_Sent}

Invite User- Email is already in use
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Add/Invite User API    ${headers}    ${invite_username_API}   ${invite_user_email_API}  ${baseStationId}
    Validate Response Code & Message   ${response}  400     error      ${Email_Already_In_Use}