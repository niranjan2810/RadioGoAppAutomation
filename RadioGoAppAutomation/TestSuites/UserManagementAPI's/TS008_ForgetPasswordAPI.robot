*** Settings ***
Documentation  This test suite will validate the Forget Password API's
Resource          ../../Utilities/Library.robot
Test Teardown   Delete All Sessions

*** Test Cases ***
#Forget Password- 200 Ok
#    [Tags]  UserManagementAPI   CloudServerAPIRegression
#    Create Header
#    Forget Password API   ${headers}    ${user_email}
#    Validate Response Code & Message    ${response}    200   message  Password is reset and send to your email

Forget Password- Unauthorized Email
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Forget Password API   ${headers}    ${EMPTY}
    Validate Response Code & Message    ${response}    404   error  ${Unauthorized_Email}

Forget Password- Internal Server Error
    [Tags]  UserManagementAPI   CloudServerAPIRegression
    Create Header
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${headers}
    ${response}=    Post Request    RadioGo    ${forgetPassword}       headers=${headers}
    Validate Response Code & Message    ${response}     500     error   ${Internal_Server_Error}
