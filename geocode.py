import pandas as pd
from geopy.geocoders import Nominatim
from geopy.extra.rate_limiter import RateLimiter
import sqlalchemy
import time

df = pd.read_csv('michigan_roster_2023.csv')

geolocator = Nominatim(user_agent='cfb_roster_analysis')
