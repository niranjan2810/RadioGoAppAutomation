*** Keywords ***
RadioGo User Login with API
    [Documentation]  This keyword will request Login API and will return response
    [Arguments]    ${email}    ${password}
    ${headers}=  Create Dictionary    Content-Type=application/json
    ${body}=    catenate    {"email": "${email}",    "deviceType": "${device_Type}",    "deviceId": "999",
    ...         "password": "${password}",    "firebaseToken": "fl12asddsad"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${headers}
    ${response}=    Post Request    RadioGo    ${login_API}    data=${body}    headers=${headers}
    [Return]    ${response}

Validate Response Code
    [Documentation]  This keyword will validate the response code given by user
     [Arguments]    ${response}     ${status_code}
     ${response_code}=    Convert To String    ${response.status_code}
     Should Be Equal    ${response_code}    ${status_code}     Response Code was Expected as:${status_code} but it was ${response_code}
     ...  values=False

Get Result Response
    [Documentation]  This keyword will convert API response to json
    [Arguments]    ${response}
    &{result}=    Evaluate    json.loads($response.content)    json
    Log    ${result}
    [Return]    ${result}

Get Access Token & BaseStationId
    [Documentation]  This keyword will retun Access Token & BaseStation Id for the user
    [Arguments]   ${email}    ${password}
    ${response}=    RadioGo User Login with API     ${email}    ${password}
    Validate Response Code      ${response}     200
    &{result}=    Evaluate    json.loads($response.content)    json
    Log    ${result}
    ${token}=    Get Value From Json    ${result}    $.token
    ${token}=    Convert To String    ${token}
    ${token}=    Remove String    ${token}    '    [    ]
    ${baseStationId}=   Get Value From Json    ${result}    $.baseStationId
    ${baseStationId}=    Convert To String    ${baseStationId}
    ${baseStationId}=    Remove String    ${baseStationId}    '    [    ]
    Set Suite Variable  ${token}    ${token}
    Set Suite Variable  ${baseStationId}    ${baseStationId}
    Delete All Sessions

Create Header
    [Documentation]  This keyord will create header as per users input
    [Arguments]    ${access-token}=default     ${token}=default
    ${headers}=    Create Dictionary    Content-Type=application/json   ${access-token}=${token}
    Set Test Variable    ${headers}      ${headers}


Add/Invite User API
    [Documentation]     This is keyword is to call Add/Invite User API and will return the response
    [Arguments]  ${header}  ${name}     ${email}    ${baseStationId}
    ${body}=    catenate   {"name": "${name}",    "email": "${email}",    "baseStationId": "${baseStationId}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${invite_User}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Logout All Users API
  [Documentation]     This is keyword is to call Logout ALl User API and will return the response
    [Arguments]  ${header}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${logout_all}       headers=${headers}
    Set Test Variable     ${response}  ${response}

Logout User API
    [Documentation]  This is keyword is to call Logout User API and will return the response
    [Arguments]  ${header}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${logout}       headers=${headers}
    Set Test Variable     ${response}  ${response}

Get User Profile API
    [Documentation]  This is keyword is to call Get User Profile API and will return the response
    [Arguments]  ${header}  ${baseStationId}
    ${body}=    catenate   {"baseStationId": "${baseStationId}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${get_User_Profile}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Delete User API
    [Documentation]  This is keyword is to call Delete User API and will return the response
    [Arguments]  ${header}  ${userId}
    ${body}=    catenate   {"userId": "${userId}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${deleteUser}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Change User Name API
    [Documentation]  This is keyword is to call Change User Name API and will return the response
    [Arguments]  ${header}  ${name}
    ${body}=    catenate   {"name": "${name}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${changeUserName}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Change Password API
    [Documentation]  This is keyword is to call Change User's Password API and will return the response
    [Arguments]  ${header}  ${oldPassword}  ${newPassword}
    ${body}=    catenate   {"oldPassword": "${oldPassword}", "password":"${newPassword}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${changePassword}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}


Change Role API
    [Documentation]  This is keyword is to call Change User Role API and will return the response
    [Arguments]  ${header}  ${userID}  ${role}
    ${body}=    catenate   {"userId": "${userID}", "role":"${role}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${changeRole}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Forget Password API
    [Documentation]  This is keyword is to call Forget Password API and will return the response
    [Arguments]  ${header}  ${email}
    ${body}=    catenate   {"email": "${email}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${forgetPassword}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Update FireBase Token API
    [Documentation]  This is keyword is to call Update Firebase API and will return the response
    [Arguments]  ${header}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo    ${updateFirebaseToken}      headers=${header}
    Set Test Variable     ${response}  ${response}

Validate Response Code & Message
    [Documentation]  This keyword will validate the response code and response body given by user
    [Arguments]     ${response}   ${response_code}   ${key}   ${message}
    Validate Response Code     ${response}  ${response_code}
    ${res}=  Get Result Response   ${response}
    Dictionary Should Contain Item     ${res}  ${key}  ${message}

Get User Id
    [Documentation]  This keyword will get the user ID
    [Arguments]     ${headers}  ${baseStationId}    ${users_name}
    Get User Profile API    ${headers}  ${baseStationId}
    Validate Response Code  ${response}  200
    ${res}=  Get Result Response   ${response}
    FOR    ${item}    IN    @{res['Users']}
       ${status}=   Run Keyword and Return Status  Should Be Equal  ${item['name']}     ${users_name}
       Run Keyword If   ${status}   Set Test Variable   ${userId}   ${item['userId']}
    END
    log   ${userId}

Create Schedule Save-it API
    [Documentation]  This is keyword is to create schedule Save-it and will return the response
    [Arguments]   ${header}    ${baseStationId}   ${startDate}  ${duration}  ${presetNumber}  ${name}
    ${body}=    catenate    {"startDate": "${startDate}",  "duration": "${duration}", "baseStationId": "${baseStationId}",
    ...     "presetNumber": "${presetNumber}", "name":"${name}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo     ${createSaveits}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Get All Save-its API
    [Arguments]   ${header}    ${baseStationId}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Get Request    RadioGo     ${getAllSaveIts}${baseStationId}    headers=${header}
    Set Test Variable     ${response}  ${response}

Get All Schedule API
    [Arguments]   ${header}    ${baseStationId}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Get Request    RadioGo     ${getAllSchedules}${baseStationId}    headers=${header}
    Set Test Variable     ${response}  ${response}

Get Ready For Download Save-its API
    [Arguments]   ${header}    ${baseStationId}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Get Request    RadioGo     ${getReadyForDownloadSaveIts}${baseStationId}    headers=${header}
    Set Test Variable     ${response}  ${response}

Get Preset API
    [Arguments]   ${header}    ${baseStationId}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Get Request    RadioGo     ${getPreset}${baseStationId}    headers=${header}
    Set Test Variable     ${response}  ${response}

Get Save-It ID
    [Arguments]  ${headers}    ${baseStationId}  ${saveItName}
    Get All Save-its API    ${headers}  ${baseStationId}
    Validate Response Code    ${response}     200
    FOR   ${item}   IN  @{response.json()}
        log     ${item}
        ${status}=  Run Keyword And Return Status   Dictionary Should Contain Value     ${item}     ${saveItName}   message=Required Save-it not found!
        Run Keyword If   ${status}   Set Test Variable   ${SaveItId}   ${item['saveItId']}
        Exit For Loop IF    ${status}
    END

Delete Save It API
    [Arguments]  ${header}    ${baseStationId}  ${saveItId}
    ${body}=    catenate   {"saveItId": "${saveItId}", "baseStationId":"${baseStationId}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo     ${deleteSaveIt}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Update Save it API
    [Arguments]  ${header}    ${baseStationId}  ${saveItId}  ${updateStartDate}
    ...     ${updatedDuration}  ${updatedPreset}  ${updatedName}
    ${body}=    catenate   {"saveItId": "${saveItId}", "startDate": "${updateStartDate}",  "duration": ${updatedDuration}, "baseStationId": "${baseStationId}","presetNumber": ${updatedPreset}, "name":"${updatedName}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${header}
    ${response}=    Post Request    RadioGo     ${updateSaveits}    data=${body}    headers=${header}
    Set Test Variable     ${response}  ${response}

Get Access Token From Back Office Sign-in API
    [Documentation]  This keyword will retun Access Token From Back Office Sign-in API
    [Arguments]   ${email}    ${password}
    ${headers}=  Create Dictionary    Content-Type=application/json
    ${body}=    catenate   {"email": "${email}", "password":"${password}"}
    Create Session    RadioGo    ${baseURLRadioGo}   headers=${headers}
    ${response}=    Post Request    RadioGo     ${backOfficeSignIn}    data=${body}    headers=${headers}
    Validate Response Code      ${response}     200
    &{result}=    Evaluate    json.loads($response.content)    json
    Log    ${result}
    ${token}=    Get Value From Json    ${result}    $.token
    ${token}=    Convert To String    ${token}
    ${token}=    Remove String    ${token}    '    [    ]
    Set Suite Variable  ${token}    ${token}
    Delete All Sessions
