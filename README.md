# 2023 College Football Recruiting Analysis

## Project Overview
A data analysis project examining recruiting patterns of 2023-24 College Football Playoff teams (Michigan, Washington, Texas, and Alabama). 
This project uses Python to analyze geographical distribution of recruits, recruiting rankings, and other patterns.

## Data Source
- College Football Data API (CFBD)
- 247sports.com for star ratings
- Nominatim for geocoding
- OpenRouteService for isochrones
- https://www2.census.gov/geo/tiger/TIGER2023/CBSA/ for Metropolitan area layer
- HTML5UP.net - Photon for HTML template

## Technologies Used
- IDE - PyCharm
- pandas for data analysis
- CFBD API for college football data
- PostgreSQL for running queries and managing data
- GitHub for version control
- QGIS for geospatial analysis
- CartoDB Positron for basemap in GIS project
- Tableau for data visualization

## Python Setup
- pip install -r requirements.txt***********UPDATE THIS LATER
- Request API Key from https://collegefootballdata.com/key
- Configure API Key

## GIS Setup
- Download .qgz file from gis/qgis directory
- Download .gpkg file from gis/data directory
- Open .qgz file and set up a connection to the .gpkg to view layers

## Process
1. Player data via cfbd api and star rating data via 247sports.com (main.py)
2. Geolocate players' hometowns with geopy (geocode.py)
3. Basic data cleaning before importing to Postgres (sql_import.py)
4. Ran SQL queries on data for insights on each school's ability to recruit various player types from across the world (sql directory)
5. Imported layer data into a GIS project
   i. Format layer data, created calculated fields that will be used for analysis

   ii. Connected players to their schools with geodesic lines

   iii. Created 1-hour isochrones for each school

   iv. Create heatmap for recruits country-wide

   v. Found the mean distance of recruits from each school

   vi. Used the mean distance to create standard deviation ellipses showing how each school recruited

   vii. Use census data to join players into metropolitan regions

   viii. Use vector analysis tools to find the per team count of players, average star ratings, and totals stars for each region

   ix. Created a competition metric based on those numbers to show which metro regions were most competitive 
       a. formula: competition_metric = (teams_per_metro/4) * (metro_total_players) * (metro_avg_stars/3)

   x. Created a success metric showing how successful each team was at recruiting in each metro
6. Imported GIS data into Tableau to create recruiting visualizations for each team
7. Downloaded HTML template off of HTML5UP and imported into IDE and repository for editing
8. Imported data into ArcGIS Online for webpage display. Ran into issues displaying my QGIS project as a webmap with the proper symbology.
