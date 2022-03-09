import datetime
import pytz
from datetime import timedelta

def bs_current_date():
    dt_today = datetime.datetime.today()                                        # Local time
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    return (dt_bs.strftime('%A, %b %d, %Y'))                                    # Returns BS current date

def bs_current_time():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    hr = int(dt_bs.strftime('%H'))
    min = dt_bs.strftime('%M')
    format = dt_bs.strftime('%p')
    bs_current_time = (str(hr) + ":" + str(min) + " " + format)
    return (bs_current_time)                                         # Returns BS current time

# For Save-it buffer not available

def bs_yest_date():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    yesterdate = dt_bs - timedelta(days=1)
    return (yesterdate.strftime('%d'))

def bs_yest_month():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    yestermonth = dt_bs - timedelta(days=1)
    return (yestermonth.strftime('%B'))

def bs_yest_year():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    yesteryear = dt_bs - timedelta(days=1)
    return (yesteryear.strftime('%Y'))

#For Future Save-it

def bs_tom_date():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    tomdate = dt_bs + timedelta(days=1)
    return (tomdate.strftime('%d'))

def bs_tom_month():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    tommonth = dt_bs + timedelta(days=1)
    return (tommonth.strftime('%B'))

def bs_tom_year():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    yesteryear = dt_bs + timedelta(days=1)
    return (yesteryear.strftime('%Y'))

# For Past Save it

def bs_past_month():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    pastmonth = dt_bs - timedelta(hours=23)
    return (pastmonth.strftime('%B'))

def bs_past_date():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    pastdate = dt_bs - timedelta(hours=23)
    return (pastdate.strftime('%d'))

def bs_past_year():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    pastyear = dt_bs - timedelta(hours=23)
    return (pastyear.strftime('%Y'))

def bs_past_hour():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    pasthour = dt_bs - timedelta(hours=23)
    return (int(pasthour.strftime('%H')))

def bs_past_min():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    pastmin = dt_bs - timedelta(hours=23)
    return (pastmin.strftime('%H'))

def bs_past_format():
    dt_today = datetime.datetime.today()
    dt_bs = dt_today.astimezone(pytz.timezone('America/New_York'))
    pastformat = dt_bs - timedelta(hours=23)
    return (pastformat.strftime('%p'))
