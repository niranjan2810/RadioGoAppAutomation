*** Settings ***
Documentation  This test suite will validate the Create Save-it API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Keywords ***
Get Start Date
        ${startDate}=   Get Current Date    UTC     -5 hours     result_format=%Y-%m-%d %H:%M
        [Return]    ${start_date}

*** Test Cases ***
Create Schedule Save-it- 200 OK
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    ${date}=    Get Current Date        UTC     -5 hours        result_format=${dateFormat}
    ${time}=    Get Current Date      UTC   -5 hours    result_format=${timeFormat}
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     2    1    My Test Save-it
    Validate Response Code & Message   ${response}  200     message
    ...     Your Save-it has been scheduled on Preset 1 at ${time} on ${date}.

Create Schedule Save-it No Token Provided
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     2    1    My Test Save-it
    Validate Response Code & Message   ${response}  402     error      ${No_Token_Provided}

Create Schedule Save-it- Unauthorised base station
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header      access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${unauthorizedBaseStationId}   ${startDate}     2    1    My Test Save-it
    Validate Response Code & Message   ${response}  403     error      ${Unauthorized_BaseStation}

Create Schedule Save-it- Unauthorised device
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}   ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     2    1    My Test Save-it
    Validate Response Code & Message  ${response}  405  error      ${Unauthorized_Device}

Create Schedule Save-it- Preset Not Found
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     2    10    My Test Save-it
    Validate Response Code & Message  ${response}  407  error      ${Preset_Not_Found}

Create Schedule Save-it- Duration less than Zero
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     -1    1    My Test Save-it
    Validate Response Code & Message  ${response}  408  error      ${SaveIt_Duration_Message}

Create Schedule Save-it- Duration equal to Zero
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     0    1    My Test Save-it
    Validate Response Code & Message  ${response}  408  error      ${SaveIt_Duration_Message}

Create Schedule Save-it- Duration more than 300
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     302    1    My Test Save-it
    Validate Response Code & Message  ${response}  408  error      ${SaveIt_Duration_Message}

Create Schedule Save-it- Duration between 0 & 300
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    ${date}=    Get Current Date        UTC     -5 hours        result_format=${dateFormat}
    ${time}=    Get Current Date      UTC   -5 hours    result_format=${timeFormat}
    Get Access Token & BaseStationId   ${owner_email_API}   ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     10    1    My Test Save-it
    Validate Response Code & Message   ${response}  200     message
    ...     Your Save-it has been scheduled on Preset 1 at ${time} on ${date}.

Create Schedule Save-it- Duration equal to 300
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    ${date}=    Get Current Date        UTC     -5 hours        result_format=${dateFormat}
    ${time}=    Get Current Date      UTC   -5 hours    result_format=${timeFormat}
    Get Access Token & BaseStationId   ${owner_email_API}   ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${startDate}     300    1    My Test Save-it
    Validate Response Code & Message   ${response}  200     message
    ...     Your Save-it has been scheduled on Preset 1 at ${time} on ${date}.

Create Past Save-it
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    ${pastDate}=    Subtract Time From Date    ${startDate}    2 days
    Get Access Token & BaseStationId   ${owner_email_API}   ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${pastDate}     10    1    My Test Save-it
    Validate Response Code & Message   ${response}  406     error   ${SaveIt_Not_Allowed_For_Selected_Time}

Create Schedule Save-it Require User or Admin Role
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${EMPTY}   ${startDate}     0    1    My Test Save-it
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Create Schedule Save-it- Unauthorized Token
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Create Schedule Save-it API    ${headers}   ${EMPTY}   ${startDate}     0    1    My Test Save-it
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Create Schedule Save-it- Internal Server Error
    [Tags]  SaveItAPI   CloudServerAPIRegression
    ${startDate}=   Get Start Date
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Create Schedule Save-it API    ${headers}   ${EMPTY}   ${startDate}     0    1    My Test Save-it
    Validate Response Code & Message  ${response}  500  error      ${Internal_Server_Error}