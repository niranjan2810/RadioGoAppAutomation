*** Settings ***
Documentation  This test suite will validate the Delete Save-it API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Variables ***
${saveItName}   Automation Delete Save-it API test

*** Keywords ***
Get Start Date
        ${startDate}=   Get Current Date    UTC     -5 hours     result_format=%Y-%m-%d %H:%M
        [Return]    ${start_date}

*** Test Cases ***
Delete Save-it 200OK
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${startDate}=   Get Start Date
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     2    1   ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Delete Save It API      ${headers}   ${baseStationId}   ${SaveItId}

Delete Save-it No Token Provided
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header
    Delete Save It API      ${headers}   ${baseStationId}   ${randomSaveItId}
    Validate Response Code & Message   ${response}  402     error      ${No_Token_Provided}

Delete Save-it Unauthorized BaseStationId
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Delete Save It API      ${headers}   ${unauthorizedBaseStationId}   ${randomSaveItId}
    Validate Response Code & Message   ${response}  403     error      ${Unauthorized_BaseStation}

Delete Schedule Save-it- Unauthorized device
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Delete Save It API      ${headers}   ${baseStationId}   ${randomSaveItId}
    Validate Response Code & Message  ${response}  405  error      ${Unauthorized_Device}

Delete Save-it- Save-it Schedule Not Found
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Delete Save It API      ${headers}   ${baseStationId}   ${randomSaveItId}
    Validate Response Code & Message   ${response}  406    error      ${SaveIt_Not_Found}

Delete Save-it Require User or Admin Role
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Delete Save It API      ${headers}   ${baseStationId}   ${randomSaveItId}
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Delete Save-it- Unauthorized Token
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Delete Save It API      ${headers}   ${baseStationId}   ${randomSaveItId}
    Validate Response Code & Message  ${response}  404   error     ${Unauthorized_Token_Message}

Delete Save-it- Internal Server Error
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Delete Save It API      ${headers}   ${baseStationId}   ${EMPTY}
    Validate Response Code & Message   ${response}  500    error      ${Internal_Server_Error}