*** Settings ***
Documentation  This test suite will validate the Change User Name API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Change User Name- 200 OK
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token        ${token}
    Change User Name API    ${headers}   Update Name
    Validate Response Code & Message    ${response}     200     message     ${UserName_Changed_Successfully}
    Get User Profile API    ${headers}   ${baseStationId}
    Validate Response Code  ${response}  200
    ${res}=  Get Result Response   ${response}
    FOR    ${node}    IN    @{res['Users']}
       Exit For Loop If   '${node['name']}'=='Update Name'
    END
    Change User Name API    ${headers}   ${owner_name_API}
    Validate Response Code  ${response}  200

Change User Name- Empty Name
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Change User Name API    ${headers}   ${EMPTY}
    Validate Response Code & Message    ${response}     401     error    ${UserName_Should_Not_Empty}

Change User Name- No token Provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Change User Name API    ${headers}   ${EMPTY}
    Validate Response Code & Message    ${response}     402     error     ${No_Token_Provided}

Change User Name- User Got Logged Out
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Change Role API   ${headers}    randomUserId   USER
    Validate Response Code & Message    ${response}     405    error    ${Unauthorized_Device}

Change User Name- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header   access-token
    Change User Name API    ${headers}   ABC
    Validate Response Code  ${response}  500