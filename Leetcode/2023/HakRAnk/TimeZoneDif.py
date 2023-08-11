# Complete the time_delta function below.
# 2
# Sun 10 May 2015 13:54:36 -0700
# Sun 10 May 2015 13:54:36 -0000
from datetime import datetime

def time_delta(t1, t2):

    timeZone1 = t1[-5:]
    timeZone2 = t2[-5:]

    d1Str= t1[:-6] # ' 10 May 2015 13:54:36'
    d2Str=t2[:-6]

    d1=datetime.strptime(d1Str[3:], " %d %B %Y %H:%M:%S")
    d2=datetime.strptime(d2Str[3:], " %d %B %Y %H:%M:%S")
    print(d1)
    print(d2)

    print(d1-d2)

    difDate=d1-d2
    difDateinSec=difDate.total_seconds()

    difInTimeZone = (int(timeZone1[:-2]) - int(timeZone2[:-2]))*60*60+(int(timeZone1[-2:]) - int(timeZone2[-2:]))*60

    difDateRemoveZoneDif = difDateinSec - difInTimeZone

    return str(abs(difDateRemoveZoneDif))[:-2]
