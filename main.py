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

        recruit_list = []

        for recruit in recruits:
            recruit_info = {
            "name": recruit.name,
            "position": recruit.position,
            "year": recruit.year,
            "stars": recruit.stars,
            "Team": recruit.committed_to,
            "height": recruit.height,
            "weight": recruit.weight,
            "city": recruit.city,
            "state": recruit.state_province,
            "country": recruit.country,
            "high_school": recruit.school
            }
            recruit_list.append(recruit_info)

            #create dataframe for recruit list
            df = pd.DataFrame(recruit_list)

        print("\n Michigan 2023 Recruits:")
        print(df)

except ApiException as e:
    print(f"Error: {e}")
