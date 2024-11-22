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
    teams_api = cfbd.TeamsApi(cfbd.ApiClient(configuration))


    return teams_api, recruiting_api

def get_recruits(recruiting_api, team):
    """this endpoint contains data on player star ratings"""
    try:
        recruit_list = []

        for year in range (2018, 2024):
            print(f"getting {year} recruits...")
            recruits = recruiting_api.get_recruiting_players(
                year=year,
                team=team
            )
            if not recruits:
                print(f"Recruits for {team}, {year} could not be found")
                continue

            for recruit in recruits:
                recruit_info = {
                "id": recruit.id,
                "athlete_id": recruit.athlete_id,
                "name": recruit.name,
                "committed_to": recruit.committed_to,
                "height": recruit.height,
                "weight": recruit.weight,
                "year": recruit.year,
                "position": recruit.position,
                "hometown": recruit.city,
                "state": recruit.state_province,
                "country": recruit.country,
                "stars": recruit.stars
                }
                recruit_list.append(recruit_info)

        df = pd.DataFrame(recruit_list)
        return df

    except ApiException as e:
        print(f"Error getting recruiting data for {team}: {e}")
        return pd.DataFrame()

def get_roster(teams_api, team, year):
    """"pull relevant roster data for 2023. recruit_ids are incomplete"""
    try:
        roster_list = []
        print(f"getting {team} roster...")
        roster = teams_api.get_roster(
            team = team,
            year = year
        )
        for player in roster:
            player_info = {
            "id": player.id,
            "name": player.first_name + " " + player.last_name,
            "team": player.team,
            "recruit_id": player.recruit_ids
            }
            roster_list.append(player_info)

        df = pd.DataFrame(roster_list)
        return df
    except ApiException as e:
        print(f"Error getting roster data for {team}: {e}")
        return pd.DataFrame()

def compare_ids(roster_df, recruits_df):
    id_match = pd.merge(
        roster_df[['name', 'id']],
        recruits_df[['name', 'id']],
        on = 'id',
        suffixes=('_roster', '_recruits')
    )
    print("matches found in roster id and recruiting id")
    print(id_match)

    athlete_match = pd.merge(
        roster_df[['name', 'id']],
        recruits_df[['name', 'athlete_id']],
        left_on='id',
        right_on='athlete_id',
        suffixes=('_roster', '_recruit')
    )
    print("match found between roster id and athlete id")
    print(athlete_match)

def main():
    teams_api, recruiting_api = api_setup()
    team = "Michigan"
    year = 2023
    recruits_df = get_recruits(recruiting_api, team)
    roster_df = get_roster(teams_api, team, year)

    compare_ids(roster_df, recruits_df)

if __name__ == "__main__":
    main()

#def get_roster
    # collect all other relevant player info for roster
    # create dataframe for roster list
   # df = pandas.DataFrame()


# were gonna have to do some data cleaning and merging