import pandas as pd
from geopy.geocoders import Nominatim
from geopy.extra.rate_limiter import RateLimiter
import sqlalchemy
import time

df = pd.read_csv('michigan_roster_2023.csv')

geolocator = Nominatim(user_agent='cfb_roster_analysis')
geocode = RateLimiter(geolocator.geocode, min_delay_seconds=1)

def get_coordinates(row):
    #check if hometown is populated
    if pd.isna(row['hometown']):
        return pd.Series([None, None])

    # combine address columns into one string
    if pd.notna(row['country']) and row['country'] != 'USA' and pd.isna(row['state']):
        # catch international players without a 'state'
        address = f"{row['hometown']}, {row['country']}"
    else:
        address = f"{row['hometown']}, {row['state']}, {row['country']}"

    print(f"getting coordinates for {row['name']}")

    try:
        #run geolocator
        location = geocode(address)
        if location:
            print(f"Found: {location.latitude}, {location.longitude}")
            #put lat and long into a list
            return pd.Series([location.latitude, location.longitude])
        else:
            # if it finds no match for the address
            print(f"No coordinates found for {address}")
            return pd.Series([None, None])

    except Exception as e:
        print(f"Error geocoding {address}: {e}")
        return pd.Series([None, None])

print("Processing players...")
df[['latitude', 'longitude']] = df.apply(get_coordinates, axis=1)

df.to_csv('michigan_geocode.csv', index=False)
print("Finished")