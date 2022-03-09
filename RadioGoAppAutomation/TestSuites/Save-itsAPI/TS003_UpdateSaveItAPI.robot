*** Settings ***
Documentation  This test suite will validate the Update Save-it API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Variables ***
${saveItName}   Create Save-it for Update
${randomDate}   2020-11-24 06:40

*** Keywords ***
Get Start Date
        ${startDate}=   Get Current Date    UTC     -5 hours     result_format=%Y-%m-%d %H:%M
        [Return]    ${start_date}

Future Date for Save-it
    ${currentDate}=   Get Current Date    UTC     -5 hours     result_format=%Y-%m-%d %H:%M
    ${futureSaveItDate} =  Add Time To Date  ${currentDate}  2 hours     result_format=%Y-%m-%d %H:%M
    [Return]    ${futureSaveItDate}

*** Test Cases ***

Update Future Save-it 200OK
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${fdate}=   Future Date for Save-it
    ${date}=    Get Current Date        UTC     -5 hours        result_format=${dateFormat}
    ${time}=    Get Current Date      UTC   -3 hours    result_format=${timeFormat}
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${fdate}     2    1   ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Update Save it API     ${headers}   ${baseStationId}   ${SaveItId}  ${fdate}    3   2   Updated Save-it
    Validate Response Code & Message   ${response}  200     message
    ...     Your Save-it has been updated on Preset 2 at ${time} on ${date}.

Update Current Save-it
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${currentDate}=   Get Start Date
    ${saveItName}=  Set Variable    Current Save-it
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${currentDate}     2    1  ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Update Save it API     ${headers}   ${baseStationId}   ${SaveItId}  ${currentDate}    3   2   Update Current Save-it
    Validate Response Code & Message   ${response}  406     error    ${SaveIt_Cannot_Be_Modified}

Update Future Save-it with Duration greater than 300
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${fdate}=   Future Date for Save-it
    ${saveItName}=  Set Variable    Create Save-it more than 300
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${fdate}     2    1   ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Update Save it API     ${headers}   ${baseStationId}   ${SaveItId}  ${fdate}    301   2   Updated Save-it
    Validate Response Code & Message   ${response}  408     error   ${SaveIt_Duration_Message}

Update Future Save-it with Duration less than 0
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${fdate}=   Future Date for Save-it
    ${saveItName}=  Set Variable    Create Save-it less than 0
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${fdate}     2    1   ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Update Save it API     ${headers}   ${baseStationId}   ${SaveItId}  ${fdate}    -1   2   Updated Save-it
    Validate Response Code & Message   ${response}  408     error   ${SaveIt_Duration_Message}

Update Future Save-it with Duration equal to 0
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${fdate}=   Future Date for Save-it
    ${saveItName}=  Set Variable    Create Save-it equal to 0
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${fdate}     2    1   ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Update Save it API     ${headers}   ${baseStationId}   ${SaveItId}  ${fdate}    0   2   Updated Save-it
    Validate Response Code & Message   ${response}  408     error   ${SaveIt_Duration_Message}

Update Save-it- No token Provided
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header
    Update Save it API     ${headers}   ${baseStationId}   ${randomSaveItId}  ${randomDate}    1  2   Updated Save-it
    Validate Response Code & Message   ${response}  402     error      ${No_Token_Provided}


Update Save-it Unauthorized BaseStationId
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${fdate}=   Future Date for Save-it
    ${saveItName}=  Set Variable    Unauthorized Base Station Id
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${fdate}     2    1   ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Update Save it API     ${headers}   ${unauthorizedBaseStationId}   ${randomSaveItId}  ${randomDate}    3   2   Updated Save-it
    Validate Response Code & Message   ${response}  403     error      ${Unauthorized_BaseStation}

Update Save-it- Unauthorized device
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Logout User API    ${headers}
    Update Save it API     ${headers}   ${baseStationId}   ${randomSaveItId}  ${randomDate}    3   2   Updated Save-it
    Validate Response Code & Message  ${response}  405  error      ${Unauthorized_Device}

Update Save-it- Preset Not Found
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}    ${owner_password_API}
    Create Header   access-token    ${token}
    ${fdate}=   Future Date for Save-it
    ${saveItName}=  Set Variable    Create Save-it equal to 0
    Create Schedule Save-it API    ${headers}   ${baseStationId}   ${fdate}     2    1   ${saveItName}
    Get Save-It ID  ${headers}   ${baseStationId}   ${saveItName}
    Update Save it API     ${headers}   ${baseStationId}   ${randomSaveItId}  ${fdate}    3   10   Updated Save-it
    Validate Response Code & Message  ${response}  407  error      ${Preset_Not_Found}

Update Save-it- Save-it Schedule Not Found
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Update Save It API      ${headers}   ${baseStationId}   ${randomSaveItId}  ${randomDate}    3   3   Updated Save-it
    Validate Response Code & Message   ${response}  406    error      ${SaveIt_Not_Allowed_For_Selected_Time}

Update Save-it Require User or Admin Role
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token From Back Office Sign-in API       ${back_office_user_email}   ${back_office_user_password}
    Create Header   access-token    ${token}
    Update Save It API      ${headers}   ${EMPTY}   ${randomSaveItId}  ${randomDate}    3   3   Updated Save-it
    Validate Response Code & Message   ${response}  403    error      ${Require_User_Or_Admin_Role}

Update Save-it- Unauthorized Token
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${unauthorized_token}
    Update Save It API      ${headers}   ${EMPTY}   ${randomSaveItId}  ${randomDate}    3   3   Updated Save-it
    Validate Response Code & Message  ${response}  404   error      ${Unauthorized_Token_Message}

Update Save-it- Internal Server Error
    [Tags]  SaveItAPI   CloudServerAPIRegression
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token    ${token}
    Update Save It API      ${headers}   ${EMPTY}   ${randomSaveItId}  ${randomDate}    3   3   Updated Save-it
    Validate Response Code & Message   ${response}  500    error      ${Internal_Server_Error}


