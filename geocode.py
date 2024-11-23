import pandas as pd
from geopy.geocoders import Nominatim
from geopy.extra.rate_limiter import RateLimiter
import sqlalchemy

team_files = [
    'michigan_roster_2023.csv',
    'washington_roster_2023.csv',
    'texas_roster_2023.csv',
    'alabama_roster_2023.csv'
]

# dataframe will contain all teams
combined_df = pd.DataFrame()

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

#process each team file
for file in team_files:
    try:
        print(f"Processing {file}...")
        team_df = pd.read_csv(file)

        team_name = file.replace('_roster_2023.csv', '').title()
        team_df['team'] = team_name

        print(f"Added {len(team_df)} players from {team_name}")
        combined_df = pd.concat([combined_df, team_df], ignore_index=True)
    except FileNotFoundError:
        print(f"Error: Could not find file {file}")
        continue
    except Exception as e:
        print(f"Error processing {file}: {e}")

combined_df[['latitude', 'longitude']] = combined_df.apply(get_coordinates, axis=1)

combined_df.to_csv('playoff_rosters_geocode.csv', index=False)
print("Finished")