import pandas as pd
import cfbd
from cfbd.rest import ApiException
from config import API_KEY

#setup api connect
configuration = cfbd.Configuration()
configuration.api_key['Authorization'] = API_KEY
configuration.api_key_prefix['Authorization'] = 'Bearer'
recruiting_api = cfbd.RecruitingApi(cfbd.ApiClient(configuration))

try:
    recruits = recruiting_api.get_recruiting_players(
        year = 2023,
        team = "Michigan"
    )

    if recruits:
        print(f"Recruits found: {len(recruits)}")
        print(f"Recruits name, position, and stars: {recruits[0].name}, {recruits[0].position}, {recruits[0].stars}")

except ApiException as e:
    print(f"Error: {e}")

