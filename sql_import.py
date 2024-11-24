import pandas as pd

df = pd.read_csv('playoff_rosters_geocode.csv')

def clean_data():
    cleaned_df = df.copy()

    numeric_columns = ['height', 'weight', 'year', 'latitude', 'longitude']
    cleaned_df[numeric_columns] = cleaned_df[numeric_columns].replace(0, None)

    text_columns = ['name', 'team', 'position', 'hometown', 'state', 'country']
    cleaned_df[text_columns] = cleaned_df[text_columns].replace('', None)

    cleaned_df['formatted_height'] = None
    for index, row in cleaned_df.iterrows():
        if pd.isna(row['height']) or row['height'] == 0:
            cleaned_df.loc[index, 'formatted_height'] = None
        else:
            feet = int(row['height'] // 12)
            remaining_inches = int(row['height'] % 12)
            cleaned_df.loc[index, 'formatted_height'] = f"{feet}'{remaining_inches}\""

    return cleaned_df

cleaned_df = clean_data()

cleaned_df.to_csv('roster_for_sql.csv', index=False)
print("Data cleaned")