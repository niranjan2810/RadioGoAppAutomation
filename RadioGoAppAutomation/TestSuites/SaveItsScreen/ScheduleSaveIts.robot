*** Settings ***
Library        DateAndTime.py
Resource       ../../Utilities/Library.robot

*** Test Cases ***
#TC 01 - Save-it not allowed for selected time.
    #Open Application    http://localhost:4723/wd/hub   platformName=iOS   platformVersion=13.5    deviceName=iPhone 8   automationName=XCUITest     app=/Users/jcbqa/Library/Developer/Xcode/DerivedData/RadioGo-dswtwayvvyfyilaytgfdiibsiakx/Build/Products/Debug-iphonesimulator/RadioGo.app     noReset=true    launchTimeout=100000
    #Sleep   5
    #${date_picker}=    DateAndTime.bs_current_date
    #Log to Console  ${date_picker}
    #click element    //XCUIElementTypeStaticText[@name="${date_picker}"]

    #${bs_yestermonth}    DateAndTime.bs_yest_month
    #input text      //XCUIElementTypePickerWheel[1]    ${bs_yestermonth}
    #${bs_yesterday}    DateAndTime.bs_yest_date
    #input text      //XCUIElementTypePickerWheel[2]    ${bs_yesterday}
    #${bs_yesteryear}    DateAndTime.bs_yest_year
    #input text      //XCUIElementTypePickerWheel[3]    ${bs_yesteryear}

    #click element   //XCUIElementTypeStaticText[@name="OK"]
    #Sleep   2
    #wait until page contains    Save-it not allowed for selected time.
    #page should contain text    Save-it not allowed for selected time.

#TC 02 - Future Save-it
    #Open Application    http://localhost:4723/wd/hub   platformName=iOS   platformVersion=13.5    deviceName=iPhone 8   automationName=XCUITest     app=/Users/jcbqa/Library/Developer/Xcode/DerivedData/RadioGo-dswtwayvvyfyilaytgfdiibsiakx/Build/Products/Debug-iphonesimulator/RadioGo.app     noReset=true    launchTimeout=100000
    #Sleep   5
    #${date_picker}=    DateAndTime.bs_current_date
    #Log to Console  ${date_picker}
    #click element    //XCUIElementTypeStaticText[@name="${date_picker}"]

    #${bs_tom_month}     DateAndTime.bs_tom_month
    #input text      //XCUIElementTypePickerWheel[1]    ${bs_tom_month}
    #${bs_tom_date}     DateAndTime.bs_tom_date
    #input text      //XCUIElementTypePickerWheel[2]    ${bs_tom_date}
    #${bs_tom_year}     DateAndTime.bs_tom_year
    #input text      //XCUIElementTypePickerWheel[3]    ${bs_tom_year}

    #click element   //XCUIElementTypeStaticText[@name="OK"]
    #Sleep   2
    #wait until page contains    Your Save-it has been scheduled
    #page should contain text    Your Save-it has been scheduled

TC 03 - Past Save-it
    Open Application    http://localhost:4723/wd/hub   platformName=iOS   platformVersion=13.5    deviceName=iPhone 8   automationName=XCUITest     app=/Users/jcbqa/Library/Developer/Xcode/DerivedData/RadioGo-dswtwayvvyfyilaytgfdiibsiakx/Build/Products/Debug-iphonesimulator/RadioGo.app     noReset=true    launchTimeout=100000
    Sleep   5
    ${date_picker}=    DateAndTime.bs_current_date
    Log to Console  ${date_picker}
    ${time_picker}=    DateAndTime.bs_current_time
    Log to Console  ${time_picker}

    click element    //XCUIElementTypeStaticText[@name="${date_picker}"]

    ${bs_past_month}     DateAndTime.bs_past_month
    input text      //XCUIElementTypePickerWheel[1]    ${bs_past_month}
    ${bs_past_date}     DateAndTime.bs_past_date
    input text      //XCUIElementTypePickerWheel[2]    ${bs_past_date}
    ${bs_past_year}     DateAndTime.bs_past_year
    input text      //XCUIElementTypePickerWheel[3]    ${bs_past_year}

    click element   //XCUIElementTypeStaticText[@name="OK"]
    Sleep   2
    click element    //XCUIElementTypeStaticText[@name="${time_picker}"]
    #//XCUIElementTypeStaticText[@name="4:31 AM"]
    ${bs_past_hour}     DateAndTime.bs_past_hour
    input text      //XCUIElementTypePickerWheel[1]    ${bs_past_hour}
    ${bs_past_min}     DateAndTime.bs_past_min
    input text      //XCUIElementTypePickerWheel[2]    ${bs_past_min}
    ${bs_past_format}     DateAndTime.bs_past_format
    input text      //XCUIElementTypePickerWheel[3]    ${bs_past_format}

    click element   //XCUIElementTypeStaticText[@name="OK"]

    Log To Console      ${bs_past_hour}
    Log To Console      ${bs_past_min}
    Log To Console      ${bs_past_format}

    #${z}=   DateAndTime.yest_date
    #Log To Console  ${z}
    #//XCUIElementTypePickerWheel[2]
    #${value1}    Get Element Attribute   //XCUIElementTypePickerWheel[2]     value
    #log to console      ${value1}
    #${value2}=   Evaluate   ${value1}-1
    #log to console      ${value2}
    #${value3}=   Evaluate   ${value1}+1
    #log to console      ${value3}
    #scroll up   //XCUIElementTypePickerWheel[2]//[value()=${value2}]
    #/XCUIElementTypePickerWheel[`value == "20"`]
    #input text      //XCUIElementTypePickerWheel[2]    ${value2}
    #click element   "//XCUIElementTypeStaticText[@name=\"${x}\"]"
    #${text}	    Get Text	//*[contains(@text,"${z}")]
    #Log To Console  ${Text}
#03 TC
    #${y}=    DateAndTime.my_time                #my_date();
    #Log to Console  ${y}
