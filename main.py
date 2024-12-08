import cfbd
import pandas as pd
from cfbd.rest import ApiException
from config import API_KEY


def api_setup():
    """ configure the teams api"""
    configuration = cfbd.Configuration()
    configuration.api_key['Authorization'] = API_KEY
    configuration.api_key_prefix['Authorization'] = 'Bearer'

    teams_api = cfbd.TeamsApi(cfbd.ApiClient(configuration))
    return teams_api


def get_roster(teams_api, team, year):
    """"pull relevant roster data for 2023. recruit_ids are incomplete"""
    try:
        roster_list = []
        print(f"getting {team} roster...")
        roster = teams_api.get_roster(
            team=team,
            year=year
        )
        for player in roster:
            player_info = {
                "id": player.id,
                "name": player.first_name + " " + player.last_name,
                "team": player.team,
                "height": player.height,
                "weight": player.weight,
                "year": player.year,
                "position": player.position,
                "hometown": player.home_city,
                "state": player.home_state,
                "country": player.home_country,
            }
            roster_list.append(player_info)

        df = pd.DataFrame(roster_list)
        print(df)
        return df
    except ApiException as e:
        print(f"Error getting roster data for {team}: {e}")
        return pd.DataFrame()


def main():
    teams_api = api_setup()
    year = 2023
    playoff_teams = ["Michigan", "Washington", "Texas", "Alabama"]

    for team in playoff_teams:
        roster_df = get_roster(teams_api, team, year)
        if not roster_df.empty:
            filename = f"{team.lower()}_roster_2023.csv"
            roster_df.to_csv(filename, index=False)
            print(f"saved {filename}")


if __name__ == "__main__":
    main()
