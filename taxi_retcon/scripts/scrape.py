import datetime
import requests
import json
import os
import time

retrieved = []
last_pos = 'Nothing'
for(dirpath,dirnames,filenames) in os.walk('taxi-test2'):
    retrieved.extend(filenames)
    break
retrieved.sort()
if len(retrieved) != 0:
    last_pos = retrieved[0].strip('.geojson').replace('_',':')
print(last_pos)

url = 'https://api.data.gov.sg/v1/transport/taxi-availability'
headers = {
           'api-key': 'Q816e22cmkF4xYpjQz2PJgsDJ4nfUkW5'
           }
           
start_date_str = '2016-12-10T12:00:00'
end_date_str = '2016-12-03T12:00:00'
dateformat = '%Y-%m-%dT%H:%M:%S'
fivemin = datetime.timedelta(minutes=5)

start_date = datetime.datetime.strptime(start_date_str, dateformat)
end_date = datetime.datetime.strptime(end_date_str, dateformat)

loopdate = start_date
if len(retrieved) != 0:
    loopdate = datetime.datetime.strptime(last_pos, dateformat)
loopdate_str = loopdate.strftime(dateformat)
loopdate_filename = loopdate_str.replace(':','_') + '.geojson'

#print(start_date.strftime(dateformat))
#print((start_date-fivemin).strftime(dateformat))

while end_date < loopdate <= start_date:
    fullurl = url + '?date_time=' + loopdate_str
    response = requests.get(fullurl, headers=headers)
    json_data = response.json()
    
    with open(os.path.join('taxi-test2', loopdate_filename), 'w') as outfile:
        json.dump(json_data, outfile, ensure_ascii=False)
        
    loopdate = loopdate - fivemin
    loopdate_str = loopdate.strftime(dateformat)
    loopdate_filename = loopdate_str.replace(':','_') + '.geojson'
    print('Next date to retrieve: ' + loopdate_str + ', waiting 60s...')
    time.sleep(60)

print("Finished mining.")