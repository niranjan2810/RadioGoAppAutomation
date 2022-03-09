*** Settings ***
Documentation  This test suite will validate the Login API's
Resource          ../../Utilities/Library.robot
Test Teardown  Delete All Sessions
*** Test Cases ***

Admin Login Response 200
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    ${response}=    RadioGo User Login with API    ${owner_email_API}   ${owner_password_API}
    Validate Response Code    ${response}     200
    ${res}=   Get Result Response      ${response}
    Dictionary Should Contain Value     ${res}      ${owner_name_API}   message=Expected Username not found in response!

Not Activated User
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    ${response}=    RadioGo User Login with API    ${invite_user_email_API}   ${owner_password_API}
    Validate Response Code & Message    ${response}     400     error   ${User_Not_Activated}

Invalid Password
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    ${response}=    RadioGo User Login with API    ${owner_email_API}   invalidPasswrd123
    Validate Response Code & Message   ${response}     401  error  ${Invalid_Password}

Invalid Email-Id
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    ${response}=    RadioGo User Login with API    inva   invalidPasswrd123
    Validate Response Code & Message    ${response}     404   error   ${Unauthorized_Email}

Login Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    ${headers}=  Create Dictionary    Content-Type=application/json
    ${body}=    catenate    {"email": "${owner_email_API}",    "deviceType": "${device_Type}",
    ...         "owner_password_API": "${owner_password_API}",    "firebaseToken": "fl12asddsad"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${headers}
    ${response}=    Post Request    RadioGo    ${login_API}    data=${body}    headers=${headers}
    ${response_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${response_code}    500     Response Code was Expected as 500 but it was ${response_code}
    &{result}=    Evaluate    json.loads($response.content)    json
    Log    ${result}
    Dictionary Should Contain Item     ${result}   error  ${Internal_Server_Error}

Device Limit Full
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    ${response}=    RadioGo User Login with API    ${owner_email_API}   ${owner_password_API}
    Validate Response Code  ${response}     200
    Get Access Token & BaseStationId   ${owner_email_API}  ${owner_password_API}
    Create Header   access-token        ${token}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${headers}
    FOR        ${i}      IN RANGE    1    10
        ${body}=    catenate    {"email": "${owner_email_API}",    "deviceType": "${device_Type}",    "deviceId": "${i}",
        ...         "owner_password_API": "${owner_password_API}",    "firebaseToken": "fl12asddsad"}
        ${response}=    Post Request    RadioGo    ${login_API}    data=${body}    headers=${headers}
        ${res}=   Get Result Response      ${response}
        ${status}=  Run Keyword and Return Status   Validate Response Code  ${response}     402
        Run Keyword IF   ${status}      Dictionary Should Contain Item     ${res}    error   ${User_Device_Limit_Full}
        Exit For Loop If    ${status} == True
    END
    ${headers}=  Create Dictionary    Content-Type=application/json     access-token=${token}
    ${response}=    Post Request    RadioGo    ${logout_all}       headers=${headers}
    Validate Response Code & Message   ${response}     200   message     ${Sign_Out_From_All_Devices}
    Delete All Sessions








