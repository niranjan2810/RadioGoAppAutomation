*** Settings ***
Library        DateAndTime.py
Resource       ../../Utilities/Library.robot

*** Test Cases ***
TC 01 - Save-it not allowed for selected time.
    Open Application    http://localhost:4723/wd/hub   platformName=iOS   platformVersion=13.5    deviceName=iPhone 8   automationName=XCUITest     app=/Users/jcbqa/Library/Developer/Xcode/DerivedData/RadioGo-dswtwayvvyfyilaytgfdiibsiakx/Build/Products/Debug-iphonesimulator/RadioGo.app     noReset=true    launchTimeout=100000
    Sleep   10
    click element       //(//XCUIElementTypeButton[@name="icon edit"])[2]
    Page Should Contain Text        Update for this Save-It is not possible as its start-time has already passed!

TC 02 - Save-it not allowed for selected time.
    Open Application    http://localhost:4723/wd/hub   platformName=iOS   platformVersion=13.5    deviceName=iPhone 8   automationName=XCUITest     app=/Users/jcbqa/Library/Developer/Xcode/DerivedData/RadioGo-dswtwayvvyfyilaytgfdiibsiakx/Build/Products/Debug-iphonesimulator/RadioGo.app     noReset=true    launchTimeout=100000
    Sleep   10
    click element       //XCUIElementTypeButton[@name="icon delete"][1]
    Page Should Contain Text        Are you sure you want to delete this Save-It?








