*** Settings ***
Documentation  This test suite will validate the Logout User API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Logout User- 200
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email}  ${password}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Validate Response Code & Message   ${response}     200  message      ${User_Signed_Out}

Logout User- User Logged Out Already
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Logout User API    ${headers}
    Validate Response Code & Message    ${response}     404  error      ${User_Already_Signed_Out}

Logout User -No token Provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Logout User API    ${headers}
    Validate Response Code & Message  ${response}     402   error     ${No_Token_Provided}

Logout All Users -Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header   access-token
    Logout User API    ${headers}
    Validate Response Code    ${response}     500


