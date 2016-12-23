import pandas as pd
import json
import os
import datetime
import pprint
import geopandas as gpd
from shapely.geometry import Point

%matplotlib inline
import matplotlib.pyplot as plt
# The two statemens below are used mainly to set up a plotting
# default style that's better than the default from matplotlib
import seaborn as sns
plt.style.use('bmh')

json_dir = os.path.join("scripts", "taxi-test")
json_filenames = []
for(dirpath,dirnames,filenames) in os.walk(json_dir):
    json_filenames.extend(filenames)
    break
json_filenames.sort()

json_path = os.path.join(json_dir, json_filenames[0])
with open(json_path, 'r') as f:
    jo = json.load(f)
    pprint.pprint(jo)
    
df = gpd.read_file(json_path)
print(df.columns.values)
print(df.head())
print(type(df))
print(type(df.ix[0])) #the GeoDataFrame is composed of pandas Series objects instead of geopandas GeoSeries objects...

series = gpd.GeoSeries(df.ix[0])
print(series['geometry'].bounds) #minx, miny, maxx, maxy for bounding box to contain multipoint geometry
print(series['geometry'].centroid) #centroid of multipoint geometry

#import basemap to a GeoDataFrame
planning_areas_filepath = os.path.join('data', 'master-plan-2014-planning-area-boundary-web', 'shp', 'MP14_PLNG_AREA_WEB_PL.shp')
plnarea_df = gpd.read_file(planning_areas_filepath)

print(plnarea_df.head())
ax=plnarea_df.plot()

#testdf = pd.concat(map(gpd.read_file, glob.glob('scripts/taxi-test/*.geojson')))
dflist_test = []
jsondir = os.path.join('scripts', 'taxi-test')
for (dirpath,dirnames,filenames) in os.walk(jsondir, topdown=False):
    for file in filenames:
        try:
            thisjsondf = gpd.read_file(os.path.join(jsondir, file))
            dflist_test.append(thisjsondf)
        except OSError as err:
            print('Empty API response file: ' + file)
            continue
        
#df_test = gpd.GeoDataFrame(pd.concat(dflist_test, ignore_index=True))
df_test = dflist_test[0]
#it's called a list comprehension, not a dataframe comprehension. This gets garbled and generates a list of dataframes.
#df_test = [df_test.append(nextdf) for nextdf in dflist_test[1:]]
for geodataframe in dflist_test[1:]:
    df_test = df_test.append(geodataframe, ignore_index=True)
print(len(df_test))
df_test.head()

def todatetime(timestampstr):
    dateformat = '%Y-%m-%dT%H:%M:%S'
    return datetime.datetime.strptime(timestampstr,dateformat)

df_test['datetime'] = df_test['timestamp'].map(lambda x: todatetime(x))
df_test['datetimeshift'] = df_test['datetime'].shift()
df_test['deltaseconds'] = (df_test['datetime'] - df_test['datetimeshift']).fillna(0).map(lambda x: x.total_seconds())
df_test.drop('datetimeshift',inplace=True,axis=1)
df_test.head()

df_test.set_index('datetime', inplace=True)
df_test.sort_index(inplace=True)
df_test.drop('api_info', inplace=True, axis=1)

#querying by datetime index
start = df_test.index.searchsorted(datetime.datetime(2016,11,26))
end = df_test.index.searchsorted(datetime.datetime(2016,12,3))
countfluxdf = pd.DataFrame(df_test.ix[start:end,['taxi_count', 'deltaseconds']])

countfluxdf.plot(subplots=True, figsize=(40, 15))
#plt.axvspan(datetime.datetime(2016,11,28), datetime.datetime(2016,11,29), color='red', alpha=0.3)
daylist=[[11,27],[11,28],[11,29],[11,30],[12,1],[12,2],[12,3]]
for day in daylist:
    plt.axvline(x=datetime.datetime(2016,day[0],day[1],0,0,0), clip_on=False)
#plt.savefig('singaporeflux.png', dpi=200)
    
# start1 = df_test.index.searchsorted(datetime.datetime(2016,11,27,12))
# end1 = df_test.index.searchsorted(datetime.datetime(2016,11,27,12,15))
flatdf = pd.DataFrame(df_test.ix[:,['geometry']])
# i don't totally understand how this next list comprehension works...
geoflat = pd.DataFrame([[i,x] for i,y in flatdf['geometry'].apply(list).iteritems() for x in y], columns=['datetime', 'taxiloc'])
# geoflat.set_index('datetime', inplace=True) # I don't want to use the datetime as index any more
print(geoflat[:20])
print(type(geoflat['taxiloc'][0]))

def point_in_plnarea(point):
    plnareas=[]
    for index, row in plnarea_df.iterrows():
        if type(row['geometry']).__name__ == 'Polygon':
            if point.within(row['geometry']):
                plnareas.append([row['REGION_N'],row['PLN_AREA_N']])
        elif type(row['geometry']).__name__ == 'MultiPolygon':
            contained = False
            for polygon in row['geometry']:
                if point.within(polygon):
                    contained = True
            if contained == True:
                plnareas.append([row['REGION_N'],row['PLN_AREA_N']])
    return plnareas
    
gfdf = gpd.GeoDataFrame(geoflat)
# print(gfdf['taxiloc'][0].within(plnarea_df['geometry'][0]))
gfdf['plnarea'] = gfdf['taxiloc'].map(lambda x: point_in_plnarea(x))

gfdf.to_csv('taxi_pip.csv', encoding='utf-8') #that dataframe took forever to generate, so I'm gonna save it to file 