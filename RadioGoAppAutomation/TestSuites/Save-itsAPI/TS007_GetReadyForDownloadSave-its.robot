*** Settings ***
Documentation  This test suite will validate the Get Ready For Download Save-it API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Get Ready For Download Save-its- 200 OK
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Get Ready For Download Save-its API    ${headers}  ${baseStationId}
    Validate Response Code    ${response}     200

Get Ready For Download Save-its- No Token Provided
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header
    Get Ready For Download Save-its API   ${headers}  ${baseStationId}
    Validate Response Code & Message   ${response}  402     error      ${No_Token_Provided}

Get Ready For Download Save-its- Unauthorized Base Station Id
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Get Ready For Download Save-its API   ${headers}  ${unauthorizedBaseStationId}
    Validate Response Code & Message   ${response}  403     error     ${Unauthorized_BaseStation}

Get Ready For Download Save-its- User Got Logged Out
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Get Ready For Download Save-its API    ${headers}  ${baseStationId}
    Validate Response Code & Message  ${response}  405  error      ${Unauthorized_Device}

Get Ready For Download Save-its- Require User or Admin Role
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Get Ready For Download Save-its API    ${headers}  ${baseStationId}
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Get Ready For Download Save-its- Unauthorized Token
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Get Ready For Download Save-its API    ${headers}  ${baseStationId}
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Get Ready For Download Save-its- Internal Server Error
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token
    Get Ready For Download Save-its API    ${headers}  ${baseStationId}
    Validate Response Code    ${response}     500