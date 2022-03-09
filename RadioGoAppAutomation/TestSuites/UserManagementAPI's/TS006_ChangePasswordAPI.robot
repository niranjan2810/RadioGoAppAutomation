*** Settings ***
Documentation  This test suite will validate the Change Password API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Change Password- 200 OK
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token        ${token}
    Change Password API    ${headers}   ${password}     newPassword123
    Validate Response Code & Message    ${response}     200     message     ${Password_Changed_Successfully}
    Get Access Token & BaseStationId   ${owner_email_API}  newPassword123
    Create Header   access-token        ${token}
    Change Password API    ${headers}   newPassword123     ${owner_password_API}
    Validate Response Code  ${response}  200

Change Password- Same Old & New Password
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token        ${token}
    Change Password API    ${headers}   ${owner_password_API}     ${owner_password_API}
    Validate Response Code & Message    ${response}     400    error    ${Different_Old_and_New_Password}

Change Password- Invalid Old Password
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token        ${token}
    Change Password API    ${headers}   oldpswd123    ${owner_password_API}
    Validate Response Code & Message    ${response}     401    error    ${Invalid_Old_Password}

Change Password - No token Provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Change Password API    ${headers}   oldpswd123    ${owner_password_API}
    Validate Response Code & Message    ${response}     402    error    ${No_Token_Provided}

Change Password- User Got Logged Out
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Change Password API    ${headers}    ${owner_password_API}    newpaswd113
    Validate Response Code & Message    ${response}     405    error    ${Unauthorized_Device}

Change Password- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header   access-token
    Logout User API    ${headers}
    Change Password API    ${headers}    ${owner_password_API}    newpaswd113
    Validate Response Code  ${response}  500

Change Password- Unauthorized Token
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Change Password API    ${headers}    ${owner_password_API}    newpaswd113
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Change Password- Require User or Admin Role
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Change Password API    ${headers}    ${owner_password_API}    newpaswd113
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Change Password- Empty New Password
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token        ${token}
    Change Password API    ${headers}   ${password}     ${EMPTY}
    Validate Response Code & Message    ${response}     401    error    ${Password_Length_Error}
