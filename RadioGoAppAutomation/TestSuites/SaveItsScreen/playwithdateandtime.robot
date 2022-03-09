*** Settings ***
Library           DateTime

*** Test Cases ***
TC 01 : Get current time and date                       # Get current date and time yy-mm-dd hr-mm-sec-msec
    ${currentdateandtime}    Get Current Date
    Log To Console    ${currentdateandtime}

TC 02 : Get current date and time in format dd-mm-yy
    ${currentinddmmyy}      get current date    result_format=%d-%m-%Y %H:%M:%S
    Log To Console      ${currentinddmmyy}

TC 03 : Get next date from current date
    ${nextday}      get current date    increment=1 day
    Log To Console    ${nextday}

TC 04 : Get next date from current date
    ${nexthour}      get current date    increment=1 hour
    Log To Console    ${nexthour}

TC 05 : Get current time only
    ${currenttime}  get current date    result_format=%H:%M:%S
    Log To Console    ${currenttime}

TC06 : Get month as string
    ${monthinstring}    get current date    result_format=%b %d, %Y
    Log To Console      ${monthinstring}

TC07 : Get epoch time
    ${epoch}        get current date    result_format=%A, %b %d, %Y
    Log To Console  ${epoch}

#"Friday, Dec 18, 2020"]

#With Python

# today = date.today()
# print("Today's date:", today)

# print (today.weekday())
# print (today.strftime('%A'))

# now_utc = datetime.now(timezone('UTC'))
# print(now_utc)

# now_asia = now_utc.astimezone(timezone('Asia/Kolkata'))
# print(now_asia.strftime(format))