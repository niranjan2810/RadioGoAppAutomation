*** Settings ***
Documentation  This test suite will validate the Get All Schedules API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Get All Schedules- 200 OK
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Get All Schedule API    ${headers}  ${baseStationId}
    Validate Response Code    ${response}     200

Get All Schedules- No Token Provided
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header
    Get All Schedule API   ${headers}  ${baseStationId}
    Validate Response Code & Message   ${response}  402     error      ${No_Token_Provided}

Get All Schedules- Unauthorized Base Station Id
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Get All Schedule API   ${headers}  ${unauthorizedBaseStationId}
    Validate Response Code & Message   ${response}  403     error     ${Unauthorized_BaseStation}

Get All Schedules- User Got Logged Out
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}   ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Get All Schedule API    ${headers}  ${baseStationId}
    Validate Response Code & Message  ${response}  405  error      ${Unauthorized_Device}

Get All Schedules- Require User or Admin Role
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Get All Schedule API    ${headers}  ${baseStationId}
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Get All Schedules- Unauthorized Token
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Get All Schedule API    ${headers}  ${baseStationId}
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Get All Schedules- Internal Server Error
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token
    Get All Schedule API    ${headers}  ${baseStationId}
    Validate Response Code    ${response}     500