*** Settings ***
Documentation  This test suite will validate the Update FireBase Token API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
Update FireBase Token- 200 Ok
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Update FireBase Token API   ${headers}
    Validate Response Code & Message    ${response}    200   message  ${Firebase_Token_Update_Message}

Update FireBase Token- No Token Provided
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Update FireBase Token API   ${headers}
    Validate Response Code & Message    ${response}    402   error  ${No_Token_Provided}


Update FireBase Token- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header   access-token
    Update FireBase Token API   ${headers}
    Validate Response Code    ${response}   500