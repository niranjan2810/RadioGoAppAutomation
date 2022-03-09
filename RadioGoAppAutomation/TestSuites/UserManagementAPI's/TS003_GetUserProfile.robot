*** Settings ***
Documentation  This test suite will validate the Get User Profile API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Get User Profile- 200 OK (Admin Login)
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Profile API    ${headers}   ${baseStationId}
    Validate Response Code  ${response}  200
    ${res}=  Get Result Response   ${response}
    FOR    ${node}    IN    @{res['Users']}
       Exit For Loop If   '${node['name']}'=='${owner_name_API}'
    END

Get User Profile- No Token Provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Get User Profile API    ${headers}   ${baseStationId}
    Validate Response Code & Message   ${response}  402     error   ${No_Token_Provided}

Get User Profile- 200 OK (User Login)
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${user_email_API}  ${user_password_API}
    Create Header   access-token    ${token}
    Get User Profile API    ${headers}   ${baseStationId}
    Validate Response Code  ${response}  200
    ${res}=  Get Result Response   ${response}
    FOR    ${node}    IN    @{res['Users']}
       Exit For Loop If   '${node['name']}'=='${users_name_API}'
    END

Get User Profile- Unauthorized BaseStation
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${user_email_API}  ${user_password_API}
    Create Header   access-token    ${token}
    Get User Profile API    ${headers}   ${unauthorizedBaseStationId}
    Validate Response Code & Message   ${response}  403    error   ${Unauthorized_BaseStation}

Get User Profile- User Got Logged Out
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Get User Profile API   ${headers}  ${baseStationId}
    Validate Response Code & Message   ${response}  405    error   ${Unauthorized_Device}

Get User Profile- Unauthorized Token
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Get User Profile API   ${headers}  ${baseStationId}
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}
    
Get User Profile- Require User or Admin Role
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Get User Profile API   ${headers}  ${baseStationId}
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Get User Profile- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Get User Profile API    ${headers}  ${EMPTY}
    Validate Response Code & Message   ${response}  500    error   ${Internal_Server_Error}


