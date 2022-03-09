*** Settings ***
Documentation  This test suite will validate the Delete User API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Delete User- No Token Provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header
    Delete User API   ${headers}    randomUserId
    Validate Response Code & Message    ${response}    402  error   ${No_Token_Provided}

Delete RadioGo User- Require Admin Role
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${user_email_API}  ${user_password_API}
    Create Header   access-token    ${token}
    Delete User API  ${headers}    randomUserId
    Validate Response Code & Message    ${response}    403   error  ${Require_Admin_Role}

Change User Role- Invalid User Id
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Delete User API  ${headers}    54ad1220-e077-11ea-a27c-9910ba54a53e
    Validate Response Code & Message    ${response}    404   error  ${User_Not_Found}

Delete User- User Got Logged Out
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${invite_username_API}
    Logout User API    ${headers}
    Delete User API   ${headers}    ${userId}
    Validate Response Code & Message    ${response}    405   error  ${Unauthorized_Device}

Delete User- Unauthorized Token
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${invite_username_API}
    Create Header   access-token    ${unauthorized_token}
    Delete User API   ${headers}    ${userId}
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Delete User- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Delete User API   ${headers}    ${EMPTY}
    Validate Response Code & Message    ${response}    500   error  ${Internal_Server_Error}

Delete User- 200 OK
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Id  ${headers}  ${baseStationId}   ${invite_username_API}
    Delete User API   ${headers}    ${userId}
    Validate Response Code & Message    ${response}    200   message  ${User_Deleted_Message}
