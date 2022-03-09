*** Settings ***
Documentation  This test suite will validate the Logout All User API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions
*** Test Cases ***

Logout All Users- 200
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email}  ${password}
    Create Header   access-token    ${token}
    Logout All Users API    ${headers}
    Validate Response Code & Message   ${response}     200  message      ${Sign_Out_From_All_Devices}

Logout All Users-User Logged Out Already
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout All Users API    ${headers}
    Logout All Users API    ${headers}
    Validate Response Code & Message   ${response}     405  error      ${Unauthorized_Device}

Logout All Users -No token Provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Logout All Users API    ${headers}
    Validate Response Code & Message    ${response}     402   error      ${No_Token_Provided}

Logout All Users -Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header   access-token
    Logout All Users API    ${headers}
    Validate Response Code    ${response}     500

