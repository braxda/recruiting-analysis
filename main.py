import pandas
import cfbd
import pandas as pd
from cfbd.rest import ApiException
from config import API_KEY

def api_setup():
    """ configure the players and recruiting APIs"""
    configuration = cfbd.Configuration()
    configuration.api_key['Authorization'] = API_KEY
    configuration.api_key_prefix['Authorization'] = 'Bearer'

    recruiting_api = cfbd.RecruitingApi(cfbd.ApiClient(configuration))
    players_api = cfbd.PlayersApi(cfbd.ApiClient(configuration))


    return players_api, recruiting_api

def get_recruits(recruiting_api, team):
    """this endpoint contains data on player star ratings"""
    try:
        recruit_list = []

        for year in range (2018, 2024):
            recruits = recruiting_api.get_recruiting_players(
                year=year,
                team=team
            )
            if not recruits:
                print(f"Recruits for {team}, {year} could not be found")
                continue

            for recruit in recruits:
                recruit_info = {
                "name": recruit.name,
                "stars": recruit.stars
                }
                recruit_list.append(recruit_info)

        df = pd.DataFrame(recruit_list)
        print(df)
        return df

    except ApiException as e:
        print(f"Error getting recruiting data for {team}: {e}")
        return pd.DataFrame()

def main():
    player_api, recruiting_api = api_setup()
    team = "Michigan"
    df = get_recruits(recruiting_api, team)

if __name__ == "__main__":
    main()

#def get_roster
    # collect all other relevant player info for roster
    # create dataframe for roster list
   # df = pandas.DataFrame()


# were gonna have to do some data cleaning and merging