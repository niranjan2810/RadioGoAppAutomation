import random
import pandas as pd
import datetime
import os
import json
from pathlib import Path

try:
    import urlparse
    from urllib import urlencode
except:  # For Python 3
    import urllib.parse as urlparse
    from urllib.parse import urlencode

def compare_date_time(statusAsOnTime, lastReportedTime):
    statusAsOnTime = pd.to_datetime(statusAsOnTime)
    lastReportedTime= pd.to_datetime(lastReportedTime)
    if lastReportedTime >= statusAsOnTime:
        return True
    else:
        return False

def generate_api_url(url, params):
    # url = "/APIGateway/fleet/CombinedHistoryReportDataV5"
    # params = {"startDate": "2020-01-21", "endDate": "2020-01-26"}

    url_parts = list(urlparse.urlparse(url))
    query = dict(urlparse.parse_qsl(url_parts[4]))
    query.update(params)

    url_parts[4] = urlencode(query)

    return urlparse.urlunparse(url_parts)


def generate_random_number(start, end):
    # print (type(int(start)))
    number = random.randint(int(start), int(end))
    # print(type(number))
    return number


