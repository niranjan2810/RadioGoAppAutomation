*** Settings ***
Documentation  This test suite will validate the Get Preset API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Keywords ***
Get Start Date
        ${startDate}=   Get Current Date    UTC     -5 hours     result_format=%Y-%m-%d %H:%M
        [Return]    ${start_date}

*** Test Cases ***
Get Preset API - 200 OK
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${startDate}=   Get Start Date
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     2    1    Get Preset API Test
    Get Preset API    ${headers}  ${baseStationId}
    Validate Response Code    ${response}     200
    Get Save-It ID  ${headers}   ${baseStationId}   Get Preset API Test
    FOR   ${item}   IN  @{response.json()}
        FOR    ${item}    IN    @{item['SaveIts']}
            ${value}=   Get From Dictionary    ${item}     saveItId
            ${status}=  Run Keyword And Return Status   Should Be Equal     ${value}        ${SaveItId}
            Run Keyword If   ${status}  Log     Created Save-it Found in the array
            Exit For Loop IF    ${status}
    END

Get Preset API- No Token Provided
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header
    Get Preset API    ${headers}  ${baseStationId}
    Validate Response Code & Message   ${response}      402     error      ${No_Token_Provided}

Get Preset API- Unauthorized BaseStationId
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${user_password_API}
    Create Header   access-token    ${token}
    Get Preset API      ${headers}   ${unauthorizedBaseStationId}
    Validate Response Code & Message   ${response}  403     error      ${Unauthorized_BaseStation}

Get Preset API- Unauthorized device
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Get Preset API      ${headers}     ${baseStationId}
    Validate Response Code & Message  ${response}  405  error      ${Unauthorized_Device}

Get Preset API Require User or Admin Role
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Get Preset API      ${headers}     ${baseStationId}
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Get All Save-its- Unauthorized Token
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Get Preset API      ${headers}     ${baseStationId}
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Get Preset API- Internal Server Error
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    default
    Get Preset API      ${headers}     ${baseStationId}
    Validate Response Code  ${response}  500